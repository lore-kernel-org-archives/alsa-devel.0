From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 23:14:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E55534B.1DC53BFA@libero.it>
References: <E18lvNx-0000A6-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >The server based approach has an added cost of an extra context switch
> >every period (about 1500 cycles on my machine i.e.), but this is fully
> >amortized by such an huge difference.
> 
> recall that (1) the context switch time is not a fixed cost but

Mine was only a very rough approximation for trivial audio generating
processes.

> depends on the memory behaviour between switches and (2) isn't it
> either two switches per participating client/application, or if they
> are chained (as in JACK), N+2 switches, where N is the number of
> clients/applications ?

I don't understand why...

Suppose that on an otherwise idle UP system we have 3 application
generating output for current pcm_dmix.
In this case we have something like ABCABCABCABC... etc.

In pcm_mix case we use a saturate/transfer/zero thread called M and the
we'll have something like ABCMABCMABCMABCM... etc.

Do you agree?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
