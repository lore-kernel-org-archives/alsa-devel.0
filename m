From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: ES8316
Date: Wed, 13 Dec 2017 23:17:10 +0200
Message-ID: <Mahogany-0.68.0-8070-20171213-231710.00@nerijus.sat.lt>
References: <Mahogany-0.68.0-8070-20171213-155300.01@nerijus.sat.lt>
 <38ce754e-818d-03ab-0ed9-e20e848c5855@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bluegene.sat.lt (bluegene.sat.lt [88.119.145.12])
 by alsa0.perex.cz (Postfix) with SMTP id 9BF40266D45
 for <alsa-devel@alsa-project.org>; Wed, 13 Dec 2017 22:18:10 +0100 (CET)
Content-Disposition: INLINE
In-Reply-To: <38ce754e-818d-03ab-0ed9-e20e848c5855@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Dec 2017 10:15:35 -0600 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> > Onda obook 20 plus tablet, Fedora 27, kernel 4.13.16-302.fc27.x86_64:
> > 
> > [    8.910172] bytcht_es8316 bytcht_es8316: ASoC: CODEC DAI ES8316 HiFi not registered
> > [    8.910306] bytcht_es8316 bytcht_es8316: snd_soc_register_card failed -517
> > 
> > kernel 4.14.3-300.fc27.x86_64:
> > 
> > [    8.561159] rt5645 i2c-10EC5645:00: Device with ID register 0xffff8d85 is not rt5645 or rt5650
> > [    9.344562] cht-bsw-rt5645 cht-bsw-rt5645: ASoC: CODEC DAI rt5645-aif1 not registered
> > [    9.344695] cht-bsw-rt5645 cht-bsw-rt5645: snd_soc_register_card failed -517
> > 
> > On both kernels snd_soc_sst_byt_cht_es8316 and snd_soc_es8316
> > modules are loaded automatically.
> > How to make audio work?
> 
> We have a known set of BIOS issues with this codec used in el-cheapo 
> platforms, see e.g. https://bugzilla.kernel.org/show_bug.cgi?id=197073
> I know that there are fixes from the android-x86 folks, but given that 
> they don't sign-off their code I am not even looking at their solution.
> 
> You'd need to provide dmesg, alsa-info.sh results. and it's better to do 
> with in bugzilla that on this mailing list.

Done - https://bugzilla.kernel.org/show_bug.cgi?id=198159
I tried to patch with es8316-Audio-exported-gpio-controlling-SPK-analog-switch.patch
(adapted to my tablet), but it didn't help, probably made it worse, as the 8316 modules
are no longer autoloaded.

Regards,
Nerijus
