From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 effect processor
Date: Mon, 27 Sep 2004 10:31:36 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096266166.7203.76.camel@krustophenia.net>
References: <Pine.LNX.4.58.0409262037130.2760@pat.dumaisnet.ca>
	 <1096251382.7203.74.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409262229110.3847@pat.dumaisnet.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409262229110.3847@pat.dumaisnet.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pat@dumaisnet.ca
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2004-09-26 at 22:35, Patrick Dumais wrote:
> I see.
> 
> So the only way to use emu10k1 effects is to load them with a loader only.
> 
> I had in mind that I could do something like this:
> snd_loadEmu10k1Effect("./vibrato.bin");
> snd_setEffectParam("vibrato",PARAM_VIBRATO_FREQ,20); // to set the
> frequency of the vibrato effect to 20hz
> 

You can do this, this is exactly what the library part of ld10k1 does.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
