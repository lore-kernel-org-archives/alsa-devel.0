From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] ASoC: zx: fix platform_no_drv_owner.cocci warnings
Date: Fri, 5 Jun 2015 10:27:23 +0800
Message-ID: <20150605022723.GA3191@wfg-t540p.sh.intel.com>
References: <201506050116.40gO5c34%fengguang.wu@intel.com>
 <20150604171126.GA226227@ivytown2>
 <20150604171659.GO14071@sirena.org.uk>
 <20150604175300.GP14071@sirena.org.uk>
 <20150605010938.GB9558@wfg-t540p.sh.intel.com>
 <1433467265.2658.15.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433467265.2658.15.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Mark Brown <broonie@kernel.org>, Jun Nie <jun.nie@linaro.org>, kbuild-all@01.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 06:21:05PM -0700, Joe Perches wrote:
> On Fri, 2015-06-05 at 09:09 +0800, Fengguang Wu wrote:
> > On Thu, Jun 04, 2015 at 06:53:00PM +0100, Mark Brown wrote:
> []
> > > These mails are CCed to kbuild-all@01.org which is generating
> > > backscatter since it's subscribers only (not even moderated for
> > > non-subscribers) - you can you please disable the mails to
> > > non-subscribers or open the list up?
> > 
> > Sure, I'll open up the list to all email addresses that have 10+
> > commits in the recent 1 year's git log.
> 
> 10 is a pretty high number, though it's ~1100 addresses

I'll also whitelist the whole domain if there are 2+ contributors
without counting their number of commits. This should reduce the
whitelist size as well as improve coverage.

> If you are adding filters, perhaps you could add all the
> listed MAINTAINERS too.

I'd expect all MAINTAINERS to be an active committer (he will at least
have some merge commits ;), so git log should be enough.

This is the script I used to generate the white list.

cd /c/repo/linux || exit

WHITELIST=/c/kernel-tests/kernel-developer-email-pattern

kernel_developer_email_list()
{
	git shortlog -e --since '1 year ago' next/master |
	grep "$1):$" |
	awk -F'[<>]' '{ print $2 }' |
	grep -v -f $WHITELIST
}

:> $WHITELIST

# show domain with 2+ contributors
kernel_developer_email_list '[0-9]' |
cut -f2 -d@ |
sed -e 's/^/^.*@/' |
sort |
uniq -c |
sort -nr |
awk '{ if ($1 >= 2) print $2 }' > $WHITELIST-new
cp $WHITELIST-new $WHITELIST

# show individual with 10+ commits
kernel_developer_email_list '[0-9][0-9]' |
sed -e 's/^/^/' >> $WHITELIST-new
mv $WHITELIST-new $WHITELIST

Here are the output:

^.*@gmail.com
^.*@intel.com
^.*@redhat.com
^.*@samsung.com
^.*@freescale.com
^.*@linaro.org
^.*@linux.vnet.ibm.com
^.*@linux.intel.com
^.*@huawei.com
^.*@ti.com
^.*@google.com
^.*@codeaurora.org
^.*@chromium.org
^.*@oracle.com
^.*@mellanox.com
^.*@qlogic.com
^.*@arm.com
^.*@amd.com
^.*@marvell.com
^.*@broadcom.com
^.*@nvidia.com
^.*@canonical.com
^.*@suse.de
^.*@kernel.org
^.*@rock-chips.com
^.*@imgtec.com
^.*@gmx.de
^.*@st.com
^.*@emulex.com
^.*@xilinx.com
^.*@renesas.com
^.*@csr.com
^.*@cn.fujitsu.com
^.*@suse.cz
^.*@avagotech.com
^.*@mentor.com
^.*@hp.com
^.*@qca.qualcomm.com
^.*@googlemail.com
^.*@citrix.com
^.*@atmel.com
^.*@iki.fi
^.*@de.ibm.com
^.*@pengutronix.de
^.*@suse.com
^.*@free-electrons.com
^.*@fb.com
^.*@windriver.com
^.*@tieto.com
^.*@microsoft.com
^.*@mediatek.com
^.*@apm.com
^.*@vmware.com
^.*@synopsys.com
^.*@realtek.com
^.*@primarydata.com
^.*@lge.com
^.*@cisco.com
^.*@web.de
^.*@sgi.com
^.*@openwrt.org
^.*@linux.com
^.*@gmx.net
^.*@diasemi.com
^.*@chelsio.com
^.*@akamai.com
^.*@sonymobile.com
^.*@ni.com
^.*@nicira.com
^.*@infradead.org
^.*@free.fr
^.*@ens.fr
^.*@codethink.co.uk
^.*@unisys.com
^.*@solarflare.com
^.*@qti.qualcomm.com
^.*@parallels.com
^.*@mvista.com
^.*@lip6.fr
^.*@hotmail.com
^.*@denx.de
^.*@cumulusnetworks.com
^.*@collabora.co.uk
^.*@au1.ibm.com
^.*@analog.com
^.*@6wind.com
^.*@xyratex.com
^.*@wizery.com
^.*@us.ibm.com
^.*@opensource.altera.com
^.*@linbit.com
^.*@jp.fujitsu.com
^.*@cogentembedded.com
^.*@caviumnetworks.com
^.*@brocade.com
^.*@axis.com
^.*@altera.com
^.*@163.com
^.*@yandex-team.ru
^.*@yahoo.fr
^.*@yahoo.com
^.*@visteon.com
^.*@vanguardiasur.com.ar
^.*@tuxdriver.com
^.*@stratus.com
^.*@pmcs.com
^.*@outlook.com
^.*@nsn.com
^.*@nokia.com
^.*@micron.com
^.*@hisilicon.com
^.*@gmx.com
^.*@gentoo.org
^.*@fastmail.fm
^.*@ericsson.com
^.*@Emulex.Com
^.*@emc.com.tw
^.*@dev.mellanox.co.il
^.*@cavium.com
^.*@amazon.de
^.*@acm.org
^.*@zoho.com
^.*@xsens.com
^.*@xes-inc.com
^.*@virtualopensystems.com
^.*@users.sourceforge.net
^.*@smartplayin.com
^.*@semihalf.com
^.*@samba.org
^.*@realsil.com.cn
^.*@profitbricks.com
^.*@posteo.de
^.*@plumgrid.com
^.*@partner.samsung.com
^.*@openvz.org
^.*@opensource.wolfsonmicro.com
^.*@netapp.com
^.*@mm-sol.com
^.*@mail.ru
^.*@linutronix.de
^.*@lemote.com
^.*@lab.ntt.co.jp
^.*@keymile.com
^.*@inktank.com
^.*@hitachi.com
^.*@globallogic.com
^.*@fau.de
^.*@ezchip.com
^.*@debian.org
^.*@ddn.com
^.*@daterainc.com
^.*@c-s.fr
^.*@cray.com
^.*@collabora.com
^.*@cloudius-systems.com
^.*@ce.jp.nec.com
^.*@baylibre.com
^.*@arista.com
^.*@android.com
^.*@alliedtelesis.co.nz
^.*@alibaba-inc.com
^.*@xsilon.com
^.*@xs4all.nl
^.*@wp.pl
^.*@vodalys.com
^.*@visionengravers.com
^.*@verge.net.au
^.*@umich.edu
^.*@uli-eckhardt.de
^.*@uclouvain.be
^.*@twitter.com
^.*@tuxera.com
^.*@tu-dresden.de
^.*@tronnes.org
^.*@toradex.com
^.*@theobroma-systems.com
^.*@tencent.com
^.*@sunrus.com.cn
^.*@stressinduktion.org
^.*@spreadtrum.com
^.*@sntech.de
^.*@skynet.be
^.*@skitlab.ru
^.*@silabs.com
^.*@secunet.com
^.*@savoirfairelinux.com
^.*@sang-engineering.com
^.*@sandisk.com
^.*@ru.ibm.com
^.*@qq.com
^.*@purestorage.com
^.*@protonic.nl
^.*@overkiz.com
^.*@osg.samsung.com
^.*@open-mesh.com
^.*@open.eurogiciel.org
^.*@online.de
^.*@noironetworks.com
^.*@newterm.pl
^.*@networkplumber.org
^.*@netfilter.org
^.*@neratec.com
^.*@motorola.com
^.*@men.de
^.*@memblaze.com
^.*@mellanox.co.il
^.*@lst.de
^.*@linux-vserver.org
^.*@linux-mips.org
^.*@linux-m68k.org
^.*@linuxfoundation.org
^.*@linux-foundation.org
^.*@laposte.net
^.*@konsulko.com
^.*@kernkonzept.com
^.*@kernellabs.com
^.*@kernel.crashing.org
^.*@jolla.com
^.*@ispras.ru
^.*@igel.co.jp
^.*@ieee.org
^.*@ideasonboard.com
^.*@hauppauge.com
^.*@green-communications.fr
^.*@googlers.com
^.*@goodmis.org
^.*@goldelico.com
^.*@ge.com
^.*@gatech.edu
^.*@gaisler.com
^.*@fr.zoreil.com
^.*@Freescale.com
^.*@freebox.fr
^.*@foxmail.com
^.*@flawful.org
^.*@ffwll.ch
^.*@fedoraproject.org
^.*@eukrea.com
^.*@endlessm.com
^.*@elproma.com.pl
^.*@ellerman.id.au
^.*@elisp.net
^.*@de.bosch.com
^.*@davemloft.net
^.*@cs.jhu.edu
^.*@comcast.net
^.*@codesourcery.com
^.*@clara.co.uk
^.*@cirrus.com
^.*@cea.fr
^.*@bjorling.me
^.*@arm.linux.org.uk
^.*@armadeus.com
^.*@amacapital.net
^.*@altlinux.org
^.*@alphalink.fr
^.*@1wt.eu
^ahmed.darwish@valeo.com
^viro@ZenIV.linux.org.uk
^viro@zeniv.linux.org.uk
^stern@rowland.harvard.edu
^alex@alex-smith.me.uk
^alexander.stein@systec-electronic.com
^aik@ozlabs.ru
^alistair@popple.id.au
^rupran@einserver.de
^aduggan@synaptics.com
^andrew@lunn.ch
^ao2@ao2.it
^arno@natisbad.org
^arnd@arndb.de
^arvid.brodin@alten.se
^asaf.vertz@tandemg.com
^axel.lin@ingics.com
^baruch@tkos.co.il
^hadess@hadess.net
^behanw@converseincode.com
^greearb@candelatech.com
^ben@decadent.org.uk
^benjamin@southpole.se
^bjorn@mork.no
^me@bobcopeland.com
^carlo@caione.org
^casey@schaufler-ca.com
^c@24.io
^wens@csie.org
^ching2048@areca.com.tw
^chris@rorvick.com
^chris@chris-wilson.co.uk
^chris@zankel.net
^email@christophjaeger.info
^clemens@ladisch.de
^cwang@twopensource.com
^clg@fr.ibm.com
^dja@axtens.net
^daniel@iogearbox.net
^daniel@zonque.org
^david@fromorbit.com
^david@hardeman.nu
^dave@stgolabs.net
^kda@linux-powerpc.org
^lifshitz@compulab.co.il
^dgilbert@interlog.com
^dudl@cypress.com
^eliot@blennerhassett.gen.nz
^emilio@elopez.com.ar
^eballetbo@iseebcn.com
^sandeen@sandeen.net
^ebiederm@xmission.com
^fthain@telegraphics.com.au
^fw@strlen.de
^frank.praznik@oh.rr.com
^geert+renesas@glider.be
^linux@horizon.com
^gerg@uclinux.org
^linux@roeck-us.net
^gclement@baobob.org
^hans@hanshq.net
^hauke@hauke-m.de
^herbert@gondor.apana.org.au
^abbotti@mev.co.uk
^ipm@chirality.org.uk
^JBottomley@Parallels.com
^jan.kiszka@siemens.com
^jason@lakedaemon.net
^jlayton@poochiereds.net
^jbarnes@virtuousgeek.org
^jiri@resnulli.us
^joe@perches.com
^joel@jms.id.au
^joern@logfs.org
^hannes@cmpxchg.org
^John.C.Harrison@Intel.com
^corbet@lwn.net
^josh@joshtriplett.org
^kadlec@blackhole.kfki.hu
^ja@ssi.bg
^julien.chauveau@neo-technologies.fr
^karl.beldan@rivierawaves.com
^Larry.Finger@lwfinger.net
^lars@metafoo.de
^LW@KARO-electronics.de
^luca.abeni@unitn.it
^luca@lucaceresoli.net
^luca.ellero@brickedbrain.com
^m.v.b@runbox.com
^damm+renesas@opensource.se
^manfred@colorfullife.com
^marcel@holtmann.org
^mgreer@animalcreek.com
^stockhausen@collogia.de
^kernel@martin.sperl.org
^yamada.m@jp.panasonic.com
^yamada.masahiro@socionext.com
^mail@beyermatthias.de
^mkrufky@linuxtv.org
^mikey@neuling.org
^madcatxster@devoid-pointer.net
^mina86@mina86.com
^michaelc@cs.wisc.edu
^mike.looijmans@topic.nl
^namit@cs.technion.ac.il
^n-horiguchi@ah.jp.nec.com
^nab@linux-iscsi.org
^der.herr@hofr.at
^hofrat@osadl.org
^nick.dyer@itdev.co.uk
^nicolas.iooss_linux@m4x.org
^green@linuxhacker.ru
^linux@rempel-privat.de
^olivier@sobrie.be
^olof@lixom.net
^osandov@osandov.com
^linux@rainbow-software.org
^kaber@trash.net
^pebolle@tiscali.nl
^paul@pwsan.com
^pavel@ucw.cz
^pefoley2@pefoley.com
^peter@hurleysoftware.com
^pmeerw@pmeerw.net
^peda@axentia.se
^plaes@plaes.org
^rabin@rab.in
^linux@rasmusvillemoes.dk
^richard@nod.at
^rickard_strandqvist@spectrumdigital.se
^imr@rtschenk.de
^rspliet@eclipso.eu
^rusty@rustcorp.com.au
^sd@queasysnail.net
^lkml14@scotdoyle.com
^popovich_sergei@mail.ua
^simon.horman@netronome.com
^stefan@agner.ch
^stefan.bruens@rwth-aachen.de
^stefan.sorensen@spectralink.com
^stefan.wahren@i2se.com
^stefano.stabellini@eu.citrix.com
^smueller@chronox.de
^s.grosjean@peak-system.com
^sfr@canb.auug.org.au
^sds@tycho.nsa.gov
^swise@opengridcomputing.com
^stratosk@semaphore.gr
^sylvain.rochet@finsecur.com
^o-takashi@sakamocchi.jp
^penguin-kernel@I-love.SAKURA.ne.jp
^tytso@mit.edu
^tgraf@suug.ch
^thomas@net.t-labs.tu-berlin.de
^niederp@physik.uni-kl.de
^tilman@imap.cc
^tharvey@gateworks.com
^tjakobi@math.uni-bielefeld.de
^tklauser@distanz.ch
^tom@herbertland.com
^tonyb@cybernetics.com
^tony@atomide.com
^varkab@cdac.in
^vincent.weaver@maine.edu
^QCA_vkondrat@QCA.qualcomm.com
^yongjun_wei@trendmicro.com.cn
^wsa@the-dreams.de
^lixiubo@cmss.chinamobile.com
^ydroneaud@opteya.com
^yguerrini@tomshardware.fr
^ysato@users.sourceforge.jp

Thanks,
Fengguang
