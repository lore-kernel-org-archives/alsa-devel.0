From: nobody@nowhere.invalid (Unknown)
Subject: Re: Q: Periodsize for capture, SBLive
Date: Mon, 18 Oct 2004 16:22:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041018142229.GA26466@stud.ntnu.no>
References: <20041018133613.GA14810@stud.ntnu.no> <200410181342.i9IDgC44003811@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200410181342.i9IDgC44003811@localhost.localdomain>
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-Id: <20041018185823.DC486EFDE9@jaguar.stud.ntnu.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 18, 2004 at 09:42:11AM -0400, Paul Davis wrote:
> >I open the sound card (a SoundBlaster Live) for capture, and
> >request a period size (using set_period_size_near()) of 8 frames,
> >but what I get is a period size of 384 frames.
>=20
> the SBlive can't go below 64 at best.=20

OK.  Any idea why I get 384?


> 8 is about the minimum anyone has ever used with any device, and that=20
> requires a fully patched 2.6 kernel with ingo's latest patches.

That touches on another thing I have been wondering about.  How is the
status of 2.6 with respect to latency?  (I have googled, and searched=20
the archives, without finding any definitive answer.  Most of what I have
found relates to 2.4.)

* Is it preferable to patch a 2.6 kernel to achieve low latency?

* Are these the patches you are talking about:
http://people.redhat.com/mingo/voluntary-preempt/ ?

(All I have found before have been 2.4-stuff, like=20
e.g. http://people.redhat.com/mingo/lowlatency-patches/.)

* If you (or others) could give a recommandation for a good card for low=20
  latency work, that would also be appreciated.


Thanks for your help!
Asbj=F8rn - ALSA newbie, but learning

--=20
Asbj=F8rn S=E6b=F8, post.doc.
Centre for Quantifiable Quality of Service in Communication Systems
Norwegian university of Science and Technology
http://www.q2s.ntnu.no




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
