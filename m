From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: [Rosegarden-devel] Rosegarden-4 native ALSA sequencer support
Date: Tue, 2 Apr 2002 17:09:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020402170903.22d35846.mdeboer@iua.upf.es>
References: <E16sOUF-00052R-00@bitone.upf.es>
	<200204021531.AFE63313@msgdirector2.onetel.net.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <200204021531.AFE63313@msgdirector2.onetel.net.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: bownie@bownie.com
Cc: rosegarden-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, erobledo@iua.upf.es
List-Id: alsa-devel@alsa-project.org

Hi Richard,

Thanks for your fast reply. I will send this message to the ALSA development
list, maybe somebody else has some comments.

>> I was wondering if you are planning to implement native ALSA (0.9) sequencer
>> support in Rosegarden-4.

> This is a whole can of worms - have a look at the mailing list archive
> for some older discussion about this.

> This is a whole can of worms - have a look at the mailing list archive
> for some older discussion about this.

I did. Just pushing a bit harder :-)

> For the moment (pre 0.2) I would say that explicit ALSA support has to be
> a complete No.  We have aRts support (such that it is) and it works (for
> me at least) well for external MIDI devices and little else.  However I
> can record and playback MIDI.  The future lies in aRts hands really -
> if they want to make an application level sequencer API that fulfills a
> lot more criteria than it does now then we'd of course be very happy.

But why would you want that? Doesn't the ALSA sequencer API fulfill
these criteria yet?

> aRts progress appears to be slow and painful though at the moment 
> and I recently complained about the opacity of the prohect to the kde-multimedia
> list.   At the moment I would however rather not get involved in ALSA and
> give aRts a bit more of a chance.  As it happens though the sequencer code
> we have should hopefully be reasonably portable to ALSA.

I have the impression that the ALSA sequencer API has been really stable for
quite a while now, and that it is not likely to change. The big backward
compatibility problems ALSA has gone through have ended, certainly now 
ALSA 0.9 has been included in the Linux 2.5.x kernel series. More and more
applications are using ALSA 0.9 natively, and I think it is only a matter 
of (short) time until all distros switch. I also believe that aRts as it is
will not be the future. But ALSA will be. I am very well aware that ALSA has
been upsetting many developers - including myself - with all the API changes
and missing documentation. But things have improved and are improving.

> I'm sure these issues will press harder the closer we get towards a properly
> user-oriented release.  At the moment (luckily) we have much to concentrate
> on outside the realms of the sound API.  ALSA releases are also coming thick
> and fast at the moment - I'd like to see the API releases stabilise somewhat
> before we even considered a port.  Don't want to be one of those apps that
> works but only for a small subset of bleeding edge developers/users.

I have not been looking into the rosegarden sourcecode, but I suppose it should
be possible to have a runtime configuration to choose between aRts or ALSA.
This would make everybody happy :-)

Maarten
