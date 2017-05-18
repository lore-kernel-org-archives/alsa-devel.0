From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Thu, 18 May 2017 09:49:53 -0300
Message-ID: <CAJcYhpb+cdC-Cro41qA0aTgEk4prrOGo0=xEuDCDsq+ksdPs+A@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
 <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
 <6615d589-9124-5f71-0d6d-e634caf2fdaa@linux.intel.com>
 <CAJcYhpatsrYyC0CRu-0quA0=NYOObMC2nro5sDE-2ssTTu83rA@mail.gmail.com>
 <bdaae069-fc68-af1d-8e40-a3e0654fa4cc@linux.intel.com>
 <CAJcYhpYwo0g3+xwSbVo6QWQVH9iGCvO-aLWUOphX4H3gVWZHRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id DDFFF267199
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 14:49:55 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id u187so5894241pgb.1
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 05:49:55 -0700 (PDT)
In-Reply-To: <CAJcYhpYwo0g3+xwSbVo6QWQVH9iGCvO-aLWUOphX4H3gVWZHRw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Android-x86 development <android-x86-devel@googlegroups.com>, Chih-Wei Huang <cwhuang@android-x86.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Pierre / List, how are you?

2017-05-15 10:10 GMT-03:00 Paulo Sergio <pstglia@gmail.com>:
> Hi Pierre
>
>
> Em 15/05/2017 09:44, "Pierre-Louis Bossart"
> <pierre-louis.bossart@linux.intel.com> escreveu:
>
> On 5/13/17 12:11 AM, Paulo Sergio wrote:
>>>
>>> * This device (Lenovo Yoga 2 1051F) is a bytcr device. However bios
>>> status returned by iosf_mbi_read is
>>>     1000000001000000000000101000000 (bits 26:27 disabled).
>>>    Had to force  bytcr flag to be true  in order to apply correct MCLK
>>> frequency (25Mhz) and use SSP0
>
>
>> Are you sure it's Baytrail-CR? where does this information come from?
>> Those fields are tied to which PMIC is used and it would be extremely
>> surprising to have a disconnect.
>
>
> Sorry, I should have said that I assumed it is a Baytrail CR device because
> these features:
>
> * it's a Z3745 soc
> * acpi_ipc_irq_index used is 0 (0x1D is the 1st index listed on dsdt, just
> like other bytcr devices)
> * ssp0 is being used on this device, not ssp2
> * it has a 25mhz clk
>
> But these are not enough to state it is a bytcr right?

I tried to find some info/document on web that shows if Z3745 is a CR
device or not, but I couldn't (comparing the launch price with other
BYT released at the same date, like Z3735G/F, it is not - however,
features match the criteria of bytcr like ssp0, acpi_ipc_irq_index,
etc )

In any case, in order to use &bytcr_rvp_platform_data, I was thinking
to add a quirk to this device. Do you think something like this would
be accepted as a patch?

--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -404,6 +404,7 @@ static unsigned long cht_machine_id;

 #define CHT_SURFACE_MACH 1
 #define BYT_THINKPAD_10  2
+#define BYT_LENOVO_YOGA2  3

 static int cht_surface_quirk_cb(const struct dmi_system_id *id)
 {
@@ -404,6 +404,7 @@ static unsigned long cht_machine_id;

 #define CHT_SURFACE_MACH 1
 #define BYT_THINKPAD_10  2
+#define BYT_LENOVO_YOGA2  3

 static int cht_surface_quirk_cb(const struct dmi_system_id *id)
 {
 {
@@ -417,6 +418,12 @@ static int byt_thinkpad10_quirk_cb(const struct
dmi_system_id *id)
        return 1;
 }

+static int byt_yoga2_quirk_cb(const struct dmi_system_id *id)
+{
+       cht_machine_id = BYT_LENOVO_YOGA2;
+       return 1;
+}
+

 static const struct dmi_system_id byt_table[] = {
        {
@@ -426,6 +433,13 @@ static const struct dmi_system_id byt_table[] = {
                        DMI_MATCH(DMI_PRODUCT_NAME, "20C3001VHH"),
                },
        },
+       {
+               .callback = byt_yoga2_quirk_cb,
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+                       DMI_MATCH(DMI_CHASSIS_VERSION, "1051F"),
+               },
+       },
        { }
 };

@@ -440,7 +454,6 @@ static const struct dmi_system_id cht_table[] = {
        { }
 };

-
 static struct sst_acpi_mach cht_surface_mach = {
        "10EC5640", "cht-bsw-rt5645", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,

&chv_platform_data };
@@ -449,6 +462,14 @@ static struct sst_acpi_mach byt_thinkpad_10 = {
        "10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,

&byt_rvp_platform_data };

+static struct sst_acpi_mach byt_thinkpad_10 = {
+       "10EC5640", "cht-bsw-rt5672", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+
&byt_rvp_platform_data };
+
+static struct sst_acpi_mach byt_lenovo_yoga2 = {
+       {"WM510204", "bytcr_wm5102", "intel/fw_sst_0f28.bin",
"bytcr_wm5102", NULL,
+
&bytcr_rvp_platform_data };
+
 static struct sst_acpi_mach *cht_quirk(void *arg)
 {
        struct sst_acpi_mach *mach = arg;
@@ -469,6 +490,8 @@ static struct sst_acpi_mach *byt_quirk(void *arg)

        if (cht_machine_id == BYT_THINKPAD_10)
                return &byt_thinkpad_10;
+       else if (cht_machine_id == BYT_LENOVO_YOGA2)
+               return &byt_lenovo_yoga2;
        else
                return mach;
