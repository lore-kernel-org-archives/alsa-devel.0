From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Fri, 21 Feb 2003 06:08:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045836495.3e5632cf4261c@webmail.namezero.com>
References: <Pine.LNX.4.44.0302202045550.1266-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302202045550.1266-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, Tomasz Motylewski <T.Motylewski@bfad.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Quoting Jaroslav Kysela <perex@suse.cz>:

> On Thu, 20 Feb 2003, Abramo Bagnara wrote:
> 
> > Now I'm able to get the same results you see.
> > 
> > However I think that we need to extract some results from this data.
> > 
> > I'll leave alone MMX optimizations because I want to compare apples with
> > apples.
> > 
> > The distributed saturation (also when it's missing the check/repeat
> > concurrency correctness part) costs more than 4 times the ticks needed
> > for a (fully correct wrt concurrency) saturate once approach for the
> > case 2048 8 32768.
> > 
> > CPU clock: 1460477150.884593
> > mix_areas0: 86747 0.031975%
> > mix_areas1: 259424 0.095623% (0)
> > mix_areas1_mmx: 253894 0.093585% (0)
> > mix_areas2: 132321 0.048773% (365)
> > mix_areas3: 332411 0.122526% (0)
> > 
> > The server based approach has an added cost of an extra context switch
> > every period (about 1500 cycles on my machine i.e.), but this is fully
> > amortized by such an huge difference.
> > 
> > What's your opinion?
> 
> Interesting is that my Intel P3 CPU has slightly different times:
> 
> pnote:/home/perex/alsa/alsa-lib/test # ./code 2048 8 32768
> Scheduler set to Round Robin with priority 99...
> CPU clock: 847.292487Mhz (UP)
> 
> Summary (the best times):
> mix_areas_srv : 576382 0.366206%
> mix_areas0    : 556852 0.353798%
> mix_areas1    : 867989 0.551480%
> mix_areas1_mmx: 625144 0.397187%
> mix_areas2    : 903335 0.573937%
> 
> areas1/srv ratio     : 1.505927
> areas1_mmx/srv ratio : 1.084600
> 
> I think that we can lose more in the client/server model. Also, note that
> we can use even futexes (if there's a hope that the possible context
> switch is acceptable) and then we can remove the cmpxchg trick and
> write-retry trick and use MMX for parallel saturation of two samples (this
> last can be used in the client/server model, too, indeed).
> 
> 						Jaroslav
> 

I'm not sure what solution you're poroposing here exactly, but it seems to go
in line with my trail of thought after seeing the results of these tests.
It seems that a fast thread unsafe implementation could have such a huge
speed advantage, that the waiting imposed on other processes because of
global locking would still be compensated. To give an example, if we can
have a 4 times quicker mixing procedure, instead of having 3 threads write
concurrently for 12 seconds (that's 4 seconds cpu time per thread), they
would write in turns - 1 second each giving a total of 3 seconds. So the
1st thread to gain access could return after 1 sec., the 2nd thread after
2 seconds and 3rd after 3. That's still better than one thread writing
alone (for 4 seconds)! Yes, there is greater latency but it seems well
compensated, at least for a reasonable number of sound sources connected.
Anything above 4 doesn't make much sense anyway if our appropach is to
saturate, rather than average - above this distortions will be very
audiable. 

And if we devise a smart locking mechanism - this latency problem can
be reduced to a minimum. The locking and unlocking code would be within
the mixing function thus preventing a badly coded application from
blocking indefinitely.

A simple locking mechanism I'm considering is the following:
- we maintain a short table of ranges locked by each client (one for each).
- access to the table is synchronized with a single mutex
- a request to lock a region could be partially realized, i.e.
  if thread 1 has locked offsets 300-500 and thread 2 wants 200-400
  it will get access to 200-300, can mix there and then ask for the
  rest.
Additionally, the mixing function could be implemented to break the
buffer sent in into chunks of say, 1024 bytes and would try to
lock and mix those segments in sequence. This would minimize the
time spent waiting for other threads. It means a sound compromise
(excuse the pun) between the convenience of not waiting for other
threads by effectively synchronizing on a per pixel basis and the
speed affored by code which doesn't need to care about synchronization,
yet is not hindered by global blocking.

Am I making myself clear or does this sound totally convoluted?

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
