From: Randy Li <ayaka@soulik.info>
Subject: [PATCH] Try to support analog audio codec at firefly reload
Date: Tue, 16 Aug 2016 04:42:06 +0800
Message-ID: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk, mark.rutland@arm.com, heiko@sntech.de, alsa-devel@alsa-project.org, Randy Li <ayaka@soulik.info>
List-Id: alsa-devel@alsa-project.org

Hello:
  This patch could enabled the es8328 codec at firefly reload board,
but it doesn't not really work. I disable the mute of channel 
Left mix and Right mix in alsamixer, I could hear the noise from
my headphone, but it never be a music. 
  I just send this patch here to see whether somebody could figure
out what is wrong, I am really not familiar with sound.

Randy Li (1):
  ARM: dts: rockchip: add analog audio support for firefly reload

 arch/arm/boot/dts/rk3288-firefly-reload.dts | 36 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.7.4
