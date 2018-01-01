From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Cherry Trail + RT5645 devices analog microphone
	not working.
Date: Mon, 1 Jan 2018 13:31:40 +0100
Message-ID: <f98183ba-0811-4688-24c6-a50790709282@redhat.com>
References: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7027476BE@RTITMBSV02.realtek.com.tw>
 <6ccb2c4c-042f-46c0-5247-90f79d49c840@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274A822@RTITMBSV02.realtek.com.tw>
 <a0540986-369c-5bca-424f-102391d85095@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274DD33@RTITMBSV02.realtek.com.tw>
 <7dcc5148-dd01-ddbb-516b-51ffd4f1c31a@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274F5AB@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 483172668F0
 for <alsa-devel@alsa-project.org>; Mon,  1 Jan 2018 13:31:42 +0100 (CET)
Received: by mail-wm0-f52.google.com with SMTP id a79so18067177wma.0
 for <alsa-devel@alsa-project.org>; Mon, 01 Jan 2018 04:31:42 -0800 (PST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70274F5AB@RTITMBSV02.realtek.com.tw>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 29-12-17 03:10, Bard Liao wrote:
>> Some questions for you:
>>
>> 1) I think enabling micbias2 may be a problem on devices with a DMIC,
>> could this be a problem?  Currently the codec driver itself contains
>> quirks for dmic pin-mapping, maybe we should leave micbias2 disabled
>> if dmic pin-mapping is specified through a quirk?
> 
> No, micbias2 and DMIC are independent and micbias2 will not be enabled
> if we don't add it in the audio route. So I don't think we need to disable it
> if dmic pin-mapping is specified.

Right, but currently we use the "Int Mic" switch in both the DMIC and analog
mic paths, and the changes to the machine driver enable micbias2 when Int Mic
gets turned on. After my changes the machine driver has:

	{"IN2P", NULL, "Int Mic"},
	{"IN2N", NULL, "Int Mic"},
  	{"DMIC L1", NULL, "Int Mic"},
  	{"DMIC R1", NULL, "Int Mic"},
...
	{"Int Mic", NULL, "micbias2"},

Since the analog mic is currently not working anyways, maybe we should
use Int Mic2 for the analog mic, so make the above:

	{"IN2P", NULL, "Int Mic2"},
	{"IN2N", NULL, "Int Mic2"},
  	{"DMIC L1", NULL, "Int Mic"},
  	{"DMIC R1", NULL, "Int Mic"},
...
	{"Int Mic2", NULL, "micbias2"},

And then use

	cset "name='Int Mic Switch2' on"

In the ucm file in the analog mic enable sequence?

This way the already working dmic support stays unchanged and the
analog mic support I'm adding does not enable micbias2 when using
dmic inputs.

?

Regards,

Hans
