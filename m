From: "Daniele (Mastro)" <daniele.bilug@gmail.com>
Subject: Re: Notebook Toshiba satellite x200-21g with realtek
 snd-hda-intel audio device still not supported (codec ALC268)
Date: Mon, 17 Dec 2007 15:13:54 +0100
Message-ID: <47668422.1030209@gmail.com>
References: <476537A5.3060805@gmail.com> <s5hprx51vuj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hprx51vuj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> The first thing you can do is to try different model options for
> snd-hda-intel module.  For example, pass model=toshiba.
> The available model value depends on the codec chip.  See
> ALSA-Configuration.txt for details.

i forgot to say i've already tried all the option i could think about

auto (default)
toshiba
3stacks
3stacks-6ch
3stacks-6ch-dig

neither one has better/worst behavior

I've checked the module has toke those option by
cat /sys/module/snd_hda_intel/parameters/model

anyway I've read the ALSA-Configuration.txt shipped with my kernel and
for Codec ALC268 it only has 2 options
3stacks
auto


I've seen other version of the kernel has two more option:
toshiba Toshiba A205
acer Acer laptops

I've googled a bit and i found out that the Toshiba A205 has completely
different problem.. the sound doesn't work with it..

so i think my audio card is an unknown model
the laptop is brand new and i only found this model in Italy
anyway i think that the same audio card is shipped with the Toshiba
Satellite x205-S7483 witch is an american laptop


one last thing... someone told me that your mailing list moved here (on
vger)... but on the alsa-project web site it say a different thing.
should i subscribe and write the same question on THAT mailing list?
