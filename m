From: Mark Swanson <mark@WebServiceSolutions.com>
Subject: Re: smix plugin available?
Date: Mon, 25 Nov 2002 22:54:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211252254.46712.mark@WebServiceSolutions.com>
References: <E18GWCQ-0006He-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18GWCQ-0006He-00@sc8-sf-list1.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On November 25, 2002 10:19 pm, Paul Davis wrote:
> 2 clarifications:
> >It is not logical for every program to write support for esd, artsd, jack,
> >alsa, etc. Programs should write to ALSA and let ALSA do software mixing
> > if required. Windows provided this since DirectX (3?). Solaris provides
> > this too (esd apparently doesn't block on Solaris).
>
> Windows provides this, true. But most "prosumer" and professional
> applications do *not* use it. The Windows kernel mixer was the curse
> of pro-ish apps for a long time, hence driver models like ASIO and now
> WDM. AFAIK, the new WDM drivers are generally used by apps in ways
> that preclude "sharing" with other apps, and certainly ASIO drivers
> cannot be shared in this way.

For "prosumer" and professional applications, lock it and block it. I have no 
idea how bad it is for miscellaneous simultaneous use of the sound device wrt 
interfering with these types of apps. But, if it is a problem - and I believe 
you that it is - then lock away. I don't think anyone would mind that. I 
don't think it interferes with what people would use smix for.

> >One of the big reasons this is affecting me is that Java sound will not
> > work unless you have a hardware mixer. My understanding is that the Sun
> > folks seem to think that it is wrong to have to implement many different
> > ways to create sound when the sound library (ALSA) should do it for them
> > - the way it works in Windows/Solaris. I completely agree with them.
>
> ALSA is *a* sound library. There are lots of things that it doesn't
> contain, and its written around a fairly specific programming
> paradigm. There are those of us (many people on LAD) who believe that
> its too hard to fit a callback-driven model into the existing ALSA
> design, and that its therefore better to implement such a model
> outside of ALSA.
>
> You see, if all apps are written to use the ALSA API, that's going to
> be great for the purposes you have in mind, but totally awful for
> those of us who want our audio apps to work in a sample synchronous
> way and ignorant of the ultimate routing of their data. Many of us
> don't think that an API based on the open/close/read/write paradigm is
> appropriate for real time streaming media.

If there was a way to temporarily disable the smix plugin, or temporarily gain 
exclusive ownership of the sound device for your purposes would that meet 
100% of your requirements?

> All that being said, I'd love to see the smix plugin implemented and
> available, if only because it would allow ALSA native apps to
> participate in a JACK system, albeit without sample synchronous
> behaviour.

Great.
Know where to find it? :-)
Even totally broken code that does not compile or do anything useful would be 
a wonderful head-start relative to starting from scratch.

Cheers.

-- 
Schedule your world with ScheduleWorld.com
http://www.ScheduleWorld.com/



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
