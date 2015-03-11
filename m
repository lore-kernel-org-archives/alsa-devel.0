From: Belisko Marek <marek.belisko@gmail.com>
Subject: ti,codec property in sound/soc/omap/omap-twl4030.c not used
Date: Wed, 11 Mar 2015 23:12:25 +0100
Message-ID: <CAAfyv34ebp1oL7t9GKT20_c4VYMM=3rfJTrj-MfT6NUBXk6d2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, alsa-devel@alsa-project.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm looking at sources for omap-twl4030.c driver which is used by many
boards. In DT bindings documentation is property ti,codec described as
mandatory but it's never parsed in driver code. I did small experiment
in gta04 board and remove ti,codec from devicetree and sound was
working. I think it can be removed from documentation and also from
various device trees. Is my assumption correct? Thanks.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
