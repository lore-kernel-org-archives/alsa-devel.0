From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 4/4] ALSA: usb-audio: Scarlett mixer
	interface for	6i6, 18i6, 18i8 and 18i20
Date: Mon, 03 Nov 2014 18:31:01 +0100
Message-ID: <5457BBD5.3050701@ladisch.de>
References: <s5h1tq0egzi.wl-tiwai@suse.de>	<1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>	<1414616163-14146-5-git-send-email-chris.j.arges@canonical.com>	<s5h8ujyc88y.wl-tiwai@suse.de>
 <5457B751.20605@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0DE1A260489
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 18:31:12 +0100 (CET)
In-Reply-To: <5457B751.20605@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris J Arges <chris.j.arges@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, robin@gareus.org, th55@gmx.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Chris J Arges wrote:
> On 10/30/2014 02:43 AM, Takashi Iwai wrote:
>> Chris J Arges wrote:
>>>
>>> +/********************** Enum Strings *************************/
>>> +static const char txtOff[] = "Off",
>>> +	     txtPcm1[] = "PCM 1", txtPcm2[] = "PCM 2",
>>> +	     txtPcm3[] = "PCM 3", txtPcm4[] = "PCM 4",
>>> +	     txtPcm5[] = "PCM 5", txtPcm6[] = "PCM 6",
>>> +	     txtPcm7[] = "PCM 7", txtPcm8[] = "PCM 8",
>>> +	     txtPcm9[] = "PCM 9", txtPcm10[] = "PCM 10",
>>> +	     txtPcm11[] = "PCM 11", txtPcm12[] = "PCM 12",
>>> +	     txtPcm13[] = "PCM 13", txtPcm14[] = "PCM 14",
>>> +	     txtPcm15[] = "PCM 15", txtPcm16[] = "PCM 16",
>>> +	     txtPcm17[] = "PCM 17", txtPcm18[] = "PCM 18",
>>> +	     txtPcm19[] = "PCM 19", txtPcm20[] = "PCM 20",
>>> +	     txtAnlg1[] = "Analog 1", txtAnlg2[] = "Analog 2",
>>> +	     txtAnlg3[] = "Analog 3", txtAnlg4[] = "Analog 4",
>>> +	     txtAnlg5[] = "Analog 5", txtAnlg6[] = "Analog 6",
>>> +	     txtAnlg7[] = "Analog 7", txtAnlg8[] = "Analog 8",
>>> +	     txtSpdif1[] = "SPDIF 1", txtSpdif2[] = "SPDIF 2",
>>> +	     txtAdat1[] = "ADAT 1", txtAdat2[] = "ADAT 2",
>>> +	     txtAdat3[] = "ADAT 3", txtAdat4[] = "ADAT 4",
>>> +	     txtAdat5[] = "ADAT 5", txtAdat6[] = "ADAT 6",
>>> +	     txtAdat7[] = "ADAT 7", txtAdat8[] = "ADAT 8",
>>> +	     txtMix1[] = "Mix A", txtMix2[] = "Mix B",
>>> +	     txtMix3[] = "Mix C", txtMix4[] = "Mix D",
>>> +	     txtMix5[] = "Mix E", txtMix6[] = "Mix F",
>>> +	     txtMix7[] = "Mix G", txtMix8[] = "Mix H";
>>
>> This is too ugly.  Can we generate strings systematically?
>
> Hi, at some point we need an array of static strings to pass into
> snd_ctl_enum_info

snd_ctl_enum_info() is a helper function to use in the common case when
you have an array of static strings.  If you create some strings
dynamically, fill out info manually.

>>> +static const struct usb_mixer_elem_enum_info opt_save = {
>>> +	.start = 0,
>>> +	.len = 2,
>>> +	.names = (const char *[]){
>>> +		"---", "Save"
>>> +	}
>>> +};
>>
>> This enum item look strange.
>
> This control is activated much like a push button, so normally its in
> the "---" state and if you active it then it triggers the "Save to HW"
> function.

"Save" is not a state.

> Is there a better way to express this control?

A mixer control that allows no access but TLV_COMMAND.
(Such a control will not be shown by 'normal' mixer applications.)


Regards,
Clemens
