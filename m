From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Audigy + FX8010 capture (hw:x,2)
Date: Mon, 05 Jul 2004 19:18:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1089069496.2540.86.camel@mindpipe>
References: <200406210745.i5L7j585017902@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406210745.i5L7j585017902@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-21 at 03:45, Peter Zubaj wrote:
> Hi,
> 
> This patch fixes capture problems from hw:x,2 on Audigy
> 
> I tested 4 channel recrding and it was OK.
> 
> hw:x,2 records outputs from FX8010 (not FX buses)
> 
> Using "EFX voices mask" you can set channels what you want record.
> 
> use alsactl store to store config
> edit this config (set true for needed channel for "EFX voices mask"
> control) - I recorded channels 8,9,14,15 (front and rear output).
> use alsactl restore to restore config
> 
> Looks like channel count must be power of 2 (1, 2, 4, 8, ...).
> 
> Peter Zubaj

Would it be possible to record an FX bus channel by connecting it to one
of the 'unused' outputs in the DSP?  That is, one of the 64 that does
not correspond to a physical soundcard output?

I believe that this might be how kX ASIO works.  The ASIO DSP plugin
only consists of 16 instructions, one for each channel, and 'connects'
them to 16 KX_FX2 GPRs, defined in the headers as 'copies of FXbus
channels for ASIO recording'.

Lee

 



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
