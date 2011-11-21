From: anish kumar <anish198519851985@gmail.com>
Subject: Firmware during bootup
Date: Tue, 22 Nov 2011 00:28:18 +0900
Message-ID: <1321889298.1760.8.camel@anish-Inspiron-N5050>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
	 <74CDBE0F657A3D45AFBB94109FB122FF1740D74C1E@HQMAIL01.nvidia.com>
	 <20111118120352.GZ19069@tbergstrom-lnx.Nvidia.com>
	 <74CDBE0F657A3D45AFBB94109FB122FF1740D74E63@HQMAIL01.nvidia.com>
	 <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111121122212.GL19069@tbergstrom-lnx.Nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Everyone,

I have a hardware(Noise processing chip) for which I am 
writing the driver.Is it a good idea to download the 
firmware in probe function by spawing kthread?I can't download
the firmware using request_firmware api as this hardware
is required during bootup for boot-up sound and request_firmware
is out of question because of no support in user-space.

Am i missing something?I am bit concerned about boot-up time
as well.

Please help me.
