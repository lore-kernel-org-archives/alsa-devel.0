From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Re: Switch to dmix pure by default?
Date: Sun, 23 Oct 2005 15:04:35 +0200
Message-ID: <20051023150435.rg5ttf7zgdgkgksc@www3.webhosting.cx>
References: <20051019154420.GA14091@piware.de>
	<s5hwtk9jv8g.wl%tiwai@suse.de> <pan.2005.10.19.18.17.37.68892@plan99.net>
	<s5hoe5kjyu9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe5kjyu9.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mike Hearn <mike@plan99.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

HI,

This has possibly become the most regularly requested feature. Is there a
tasklist that has this as a priority?

Cheers.

Quoting Takashi Iwai <tiwai@suse.de>:

> At Wed, 19 Oct 2005 19:17:37 +0100,
> Mike Hearn wrote:
>>
>> On Wed, 19 Oct 2005 19:02:23 +0200, Takashi Iwai wrote:
>> > dmix uses mmap, and assumes fine enough periods.  So, it wouldn't work
>> > well the cards supporting only 2 periods, for example.
>>
>> Is that for performance? I don't really understand why dmix can't just,
>> well, mix the streams together and then forward it on as a regular
>> bytestream using the non-mmap interface. Esound works with any hardware,
>> so couldn't dmix have a compatibility mode?
>
> The question is not doable or not.  It's a completely different
> design.
>
> The mix "server" like esound does:
> - _read_ the data from clients
> - mix them
> - wright them to h/w
> Because of this mechanism, it requires smaller period to achieve the
> low latency.
>
> OTOH, dmix lets its processes mixing by themselves.  There is no read
> or write server operation, i.e. there is no real mix "server".
> (In practice, dmix has a resource server, which is used only to pass
> the file descriptor for mmap.)
> Each client mmaps the very same h/w buffer, and add/sub the data on
> the buffer atomically as write.
>
> Of course, it's possible to implement ALSA-mixing server a la
> esound/arts for the hardwares without mmappable buffers.
> But, it's just an idea and a plan, so far.  Volunteers are always
> appreciated ;)
>
>
> Takashi
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



--
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/ - The Linux Audio Users guide
Http://www.djcj.org/gigs - Gigs Guide Korea
========================================

Being on stage with the band in front of crowds shouting, "Get off! No!
We want normal music!", I think that was more like acting than anything
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
