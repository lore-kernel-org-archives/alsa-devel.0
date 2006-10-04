From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [alsa-cvslog] alsa-kernel: emu10k1: Fix outl()
	in	snd_emu10k1_resume_regs()
Date: Wed, 04 Oct 2006 18:36:19 +0200
Message-ID: <85r6xo598c.fsf@orfeo.duckcorp.org>
References: <ALOGGER1159978767.86@alsa-project.org>
	<4523DFF2.4020105@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4523DFF2.4020105@superbug.co.uk> (James Courtier-Dutton's
	message of "Wed, 04 Oct 2006 17:23:14 +0100")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton <James@superbug.co.uk> writes:

> Takashi Iwai wrote:
>> -		outl(emu->port + A_IOCFG, emu->saved_a_iocfg);
>> -	outl(emu->port + HCFG, emu->saved_hcfg);
>> +		outl(emu->saved_a_iocfg, emu->port + A_IOCFG);
>> +	outl(emu->saved_hcfg, emu->port + HCFG);
>>   
> Is there any tool to find out who got this wrong in the first place?

Git or gitweb. I think also that hg should have also the history

FYI, a quick look to gitweb, gives this commit :
http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=09668b441dacdf4640509b640ad73e24efd5204f


Regards,
Arnaud


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
