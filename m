From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] SOC: UDA134x: Enable POWER_OFF_ON_STANDBY define.
Date: Tue, 3 May 2011 13:09:27 +0200
Message-ID: <BANLkTimE_TEzManZb2McLnohqbc27hRZ=w@mail.gmail.com>
References: <1304415149-19725-1-git-send-email-marek.belisko@open-nandra.com>
	<20110503100042.GA1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110503100042.GA1762@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 3, 2011 at 12:00 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 03, 2011 at 11:32:29AM +0200, Marek Belisko wrote:
>> Without this define we can't get any sound from codec so enable
>> it by default. This define unlock bias settings which control
>> power control for DAC and ADC (by default 0 0 which is off off).
>
> If this is essential why is it optional in the first place?
Not sure about background. Maybe whole define should be removed
This change was introduced in commit:f0fba2ad

>

regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
