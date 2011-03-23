From: Steve Calfee <stevecalfee@gmail.com>
Subject: Connecting a codec to an i2c codec driver.
Date: Tue, 22 Mar 2011 17:40:54 -0700
Message-ID: <4D894196.4040002@gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>	<4D821A18.30407@ladisch.de>
	<AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f177.google.com (mail-px0-f177.google.com
	[209.85.212.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E1A9103806
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 01:41:02 +0100 (CET)
Received: by pxi10 with SMTP id 10so1557783pxi.8
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 17:40:58 -0700 (PDT)
In-Reply-To: <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hi,

I have a beagleboard xm and have a trainer board installed, so that adds another i2c bus, which with some platform tweaks I now have as /dev/i2c-2

I can use i2ctools and i2cdump my codec on that i2c bus, connected up on the platform data stuff.

I can modprobe the driver (in this case snd_soc_max98088), and no alsa "cards" or other linkages are established.

I got the i2c_probe routine to finally be called when I set the driver name to match the platform name:

static struct i2c_board_info __initdata beagle_i2c_trainer_boardinfo[] = {
	{
		I2C_BOARD_INFO("max98088", 0x10),
		.flags = I2C_CLIENT_WAKE,
		.irq = INT_34XX_SYS_NIRQ,
		.platform_data =&beagle_twldata,
	},
};

But then my max98088 probe routine was never called.

1) Is there a way to connect the i2c bus to a codec driver without having it built in the platform code?

2) What is the proper way to connect using a platform connection with multiple i2c buses and devices?

Thanks, Steve
