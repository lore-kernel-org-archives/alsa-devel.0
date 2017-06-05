From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: add bytcr-wm5102 machine
	driver
Date: Mon, 5 Jun 2017 14:01:33 -0300
Message-ID: <CAJcYhpbvf5ZSWoHW_uUocMtf9n7998GsLrjSrARXagB+La-tvw@mail.gmail.com>
References: <593313f5.3636c80a.50e05.47e9@mx.google.com>
 <df6f715c-5f63-9403-8dd0-13dad8f62fa6@linux.intel.com>
 <CAJcYhpbxWicEAOheSw9mdHibxQ2RPVQfZ4ncDvtQ5YEwtY=xWg@mail.gmail.com>
 <d984fbdc-bea2-d875-c9e8-b1aeec6a666d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <d984fbdc-bea2-d875-c9e8-b1aeec6a666d@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: pstglia@android-x86.org, alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> well no, this isn't the right way to do this. quirks need to be based on
>>> real hardware information (e.g. DMI) and not a driver name.
>>
>> Thanks for the review. Could I use dmi_match function inside is_byt_cr?
>
>
> Yes, however it's the first time I see a quirk based on DMI_CHASSIS_VERSION.
> we use PRODUCT or BOARD usually.

Not a problem. I can change it. I have these info available from dmi:

bios_date: 08/01/2014
bios_vendor: LENOVO
bios_version: 01WT17WW
board_asset_tag: NO Asset Tag
board_name: INVALID
board_serial: HA07YER9
board_vendor: LENOVO
board_version: SDK9A6N2HVWIN
chassis_asset_tag: NO Asset Tag
chassis_serial: HA07YER9
chassis_type: 11
chassis_vendor: LENOVO
chassis_version: 1051F
modalias: dmi:bvnLENOVO:bvr01WT17WW:bd08/01/2014:svnLENOVO:pn60073:pvr1051F:rvnLENOVO:rnINVALID:rvrSDK9A6N2HVWIN:cvnLENOVO:ct11:cvr1051F:
product_name: 60073
product_serial: HA07YER9
product_uuid: 39FFE49E-1918-884A-9499-CC7705A289C9
product_version: 1051F
sys_vendor: LENOVO
uevent: MODALIAS=dmi:bvnLENOVO:bvr01WT17WW:bd08/01/2014:svnLENOVO:pn60073:pvr1051F:rvnLENOVO:rnINVALID:rvrSDK9A6N2HVWIN:cvnLENOVO:ct11:cvr1051F:
