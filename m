From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] [PATCH 0/4 V7] Power-well API
 implementation for Haswell
Date: Wed, 24 Jul 2013 13:57:55 +0200
Message-ID: <51EFC143.2090603@canonical.com>
References: <46B810F6945F7C4788E11DCE57EC48901184D8BF@SHSMSX104.ccr.corp.intel.com>
	<s5h38rdmyh0.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184DB13@SHSMSX104.ccr.corp.intel.com>
	<s5hwqoplhv4.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184DB3D@SHSMSX104.ccr.corp.intel.com>
	<CA+gsUGTCimKS35XaX7V+aWXtmGBeHS2ftChU5ndzsray5Aipuw@mail.gmail.com>
	<s5hwqopthff.wl%tiwai@suse.de>	<51E6A4B7.7060605@canonical.com>
	<s5hsizdtgg8.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC48901184E3B6@SHSMSX104.ccr.corp.intel.com>
	<20130718064415.GH4550@phenom.ffwll.local>
	<46B810F6945F7C4788E11DCE57EC48901184E58D@SHSMSX104.ccr.corp.intel.com>
	<s5h61w8tdnb.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC489011851134@SHSMSX104.ccr.corp.intel.com>
	<s5h38r4p6fc.wl%tiwai@suse.de>
	<46B810F6945F7C4788E11DCE57EC4890118511BE@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <46B810F6945F7C4788E11DCE57EC4890118511BE@SHSMSX104.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "Wang, Xingchao" <xingchao.wang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, Takashi Iwai <tiwai@suse.de>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
List-Id: alsa-devel@alsa-project.org

On 07/24/2013 01:33 PM, Wang, Xingchao wrote:
> Yes, I agree. I'm debugging this issue on Ubuntu, not sure it happens on other distribution too.
> If it's related to Ubuntu, maybe need check Ubuntu power policy. Does anyone know the Ubuntu power-policy on laptop?
> i.e. when charger connected, will Ubuntu make decision to disable power-save feature for audio subsystem?

I'm not a power management expert, but I got a pointer from my team mate 
to pm-utils:

http://cgit.freedesktop.org/pm-utils/tree/pm/power.d/intel-audio-powersave

If I understand correctly, The scripts in power.d are executed when 
battery / AC-power is changed.

Takashi, does SUSE also use pm-utils?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
