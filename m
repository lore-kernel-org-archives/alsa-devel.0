From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: OSS SNDCTL_DSP_GETISPACE, non-blocking read: messy :-\
Date: Mon, 27 Oct 2003 13:11:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031027121158.GA30019@rhlx01.fht-esslingen.de>
References: <20031025200221.GA6415@rhlx01.fht-esslingen.de> <s5hbrs27uu6.wl@alsa2.suse.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hbrs27uu6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On Mon, Oct 27, 2003 at 01:01:37PM +0100, Takashi Iwai wrote:
> At Sat, 25 Oct 2003 22:02:21 +0200,
> Andreas Mohr wrote:
> > Or, as a short summary:
> > The application is perfectly well aware of how many bytes there are left
> > to read (from calling SNDCTL_DSP_GETISPACE) and then does a read() with
> > this amount of bytes, however since the ALSA OSS layer attempts to read
> > this byte amount in blocks of runtime->oss.period_bytes bytes from the sound
> > device, we ARTIFICIALLY cause a -EAGAIN to be returned due to insufficient
> > available data, thus potentially confusing many OSS applications.
> > 
> > Now what to do here?
> 
> this problem is a bit touch, because the ALSA OSS layer does the
> sample-rate conversion, etc.
> when the sample rate is converted between 44.1kHz and 48kHz, some
> round error may happen and it will be accumulated.   hence, the size
> will be different between two cases: reading a whole period once and
> reading a period by multiple calls.
> 
> i'll take a more deeper look...
Ah, thanks! (also for the explanation given above)

Given that 1.0 is approaching, it'd certainly be useful to get such a
problem fixed ;-)

Andreas Mohr


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
