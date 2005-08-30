From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-devel] Re: ALSA / emu10k1 / SPDIF / surround?
Date: Tue, 30 Aug 2005 13:59:33 -0400
Message-ID: <1125424773.19563.3.camel@mindpipe>
References: <Pine.HPX.4.33n.0508301149380.18036-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508301149380.18036-100000@studcom.urz.uni-halle.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Thomas Zehetbauer <thomasz@hostmaster.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-30 at 11:53 +0200, Clemens Ladisch wrote:
> Lee Revell wrote:
> > So maybe the distortion problem here is just an app that's sending
> > a clipped signal.
> 
> It's a known problem with several cards that use the STAC9708 codec.
> It seems the chip doesn't get initialized/configured correctly;
> several registers aren't documented.
> 

Should be trivial to RE using the kX driver (the kxctrl utility lets you
read and write AC97 registers).

Thomas, are you willing to install Windows to track this bug down?  :-P

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
