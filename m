From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Fri, 13 Dec 2002 19:24:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFA25F1.2000705@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de>	<s5h3cp3uorz.wl@alsa2.suse.de>	<m27keexn25.fsf@vador.mandrakesoft.com>	<3DF9C1CD.3090205@gmx.de>	<s5hisxxubkx.wl@alsa2.suse.de>	<3DFA1166.2020409@gmx.de> <s5hel8lua27.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

 >>lspci -n output:
 >>
 >>00:0b.0 Class 0401: 1319:0801 (rev a0)
 >>00:0b.1 Class 0980: 1319:0801 (rev a0)
 >>
 >>
 >
 >thanks, could you try the attached patch?
 >at least, the weird messages for allocation of invalid i/o ports
 >should disappear.  not sure whether this cures the lock-up problem,
 >though.
 >
 >
 >Takashi
 >
 >
done. The error in /var/log/messages doesn't appear any longer (I only
get these 'sharing IRQ ...' messages). Thanks! But the system still
locks up when stopping playback :-(

fe





-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
