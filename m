From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [alsa-devel] Asynchronous notification in
	ALSA - I/O Plugin -	Pulseaudio
Date: Thu, 22 May 2008 00:29:36 +0200
Message-ID: <20080521222936.GB12214@tango.0pointer.de>
References: <s5hfxsd9qt6.wl%tiwai@suse.de>
	<18027403.3701211352364970.JavaMail.root@intra>
	<s5hprrgvsre.wl%tiwai@suse.de>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
Content-Disposition: inline
In-Reply-To: <s5hprrgvsre.wl%tiwai@suse.de>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: alsa-devel@alsa-project.org, pulseaudio-discuss@mail.0pointer.de
List-Id: alsa-devel@alsa-project.org

On Wed, 21.05.08 12:47, Takashi Iwai (tiwai@suse.de) wrote:

> > > I have experimental patches to add async support to ioplug.  With a
> > > quick test using jack plugin, it seems working somehow.  Will post
> > > them alsa-devel now.
> > 
> > Thank you!  I tested these with Firefox + Flash 9 + Pulseaudio, and while
> > sound output works, quitting any Flash application will freeze firefox.
> 
> It's a showstopper, then.  Could you figure out in which code does it
> freeze?  My change is just to add async call, so it sounds like that
> another hidden bug is hit by my change...

That freeze is an unfixable race condition that Flash has when
shutting down audio.

See the explanation down on http://pulseaudio.org/ticket/267

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
