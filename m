From: Richard Cochran <cochran@cs.umass.edu>
Subject: Re: documentation - yeah right!
Date: Thu, 22 May 2003 10:18:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030522101823.B29826@loki.cs.umass.edu>
References: <20030521104349.A793@loki.cs.umass.edu> <200305211518.h4LFI2jE027163@mail.cs.umass.edu> <20030521120928.C793@loki.cs.umass.edu> <s5hof1vqhb4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hof1vqhb4.wl@alsa2.suse.de>; from tiwai@suse.de on Thu, May 22, 2003 at 02:47:27PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks to all who wrote about how Alsa works. If you collect these
facts together, you have the beginnings of a design document! When I
finally undertake to understand Alsa (a daunting task), I will be
happy to reconstruct an architecture description for Alsa.

Let me summarize what I have learned (please comment if needed):

1. Alsa has clearly stated feature and performance goals. However,
there is no overall design document (block diagram, notes on a napkin,
etc) describing how the architecture will reach these goals. Some of
the design may be gleened from the list archives, or from reading
example programs and Alsa sources.

2. Alsa is being developed by a very small number of people (a good
thing, IMHO). These same people are actively involved in major audio
software projects for this platform. The actual direction of the Alsa
development comes from practical experience with these apps.

3. Alsa has gone through substantial rewrites. The latest version is
fairly stable, however.

4. One of the major advantages of Alsa is the transparent conversion
and mixing library. The same functionality is provided in a different
way by JACK.

5. The latency (time from write() to DAC, or from ADC to read()) is
not worse using the Alsa API and drivers as compared with OSS API and
drivers.

I have two additional questions:

On Thu, May 22, 2003 at 02:47:27PM +0200, Takashi Iwai wrote:
> - ALSA is not only the driver.
> - ALSA model is still Unix style (somehow).
> - ALSA library is the low-level library.

Are the calls snd_pcm_* kernel calls or library calls? If the latter,
where is the library-kernel API?

When using the Alsa OSS compatibility layer, is there a performace
penalty in terms of latency?

Will OSS support likely be dropped in kernel 2.6?

How are the OSS drivers "thread unsafe", or rather, what are the
thready safety issues that Alsa addresses?

Thanks,

Richard


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
