From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: Audio support for codec Philips UDA1380
Date: Fri, 04 Nov 2005 13:43:41 +0100
Message-ID: <85wtjo4m82.fsf@Orfeo.duckcorp.org>
References: <200511041201.01260.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200511041201.01260.giorgio@mandarinlogiq.org> (Giorgio Padrin's
	message of "Fri, 4 Nov 2005 12:01:01 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giorgio Padrin <giorgio@mandarinlogiq.org>
Cc: alsa-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Giorgio Padrin <giorgio@mandarinlogiq.org> writes:

> Hi all,
>

Hi !

> I want to contribute code to support audio codec Philips UDA1380.
> Download from: "http://www.mandarinlogiq.org/PXA2xx i2Sound/"
>
> Clean write for ALSA and kernel 2.6 with full power optimizations at subchip 
> level, enabling hw blocks on need. Looking around in the kernel, this seems 
> to be a novelty among sound drivers, that run commonly in an 
> all-always-powered-up manner.
>
> See h2200_audio (also on the site) for a sample glue module, that support the 
> audio of an iPAQ h2200 handheld, using it together with a complementary module 
> for the Intel PXA2xx I2S audio.
>

So, the uda1380 module is generic enough to be used on non PXA boards ?


> I wish to know whether there are other similar works in development.

uda1380 with i2s support was on my todo list but I think I will remove it as
you've done it :)

Do you plan to send it to the ALSA folks ?

Regards,
Arnaud



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
