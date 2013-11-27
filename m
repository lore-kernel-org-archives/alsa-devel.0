From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Commit:ce6cfaf1 query for shared control
Date: Wed, 27 Nov 2013 08:41:05 +0100
Message-ID: <5295A211.9050801@metafoo.de>
References: <CAES_P+-+CmRw5YYWeDPLd8-tn8tVCHmvJgWu9SS=TdeTnWzNUA@mail.gmail.com>
 <5293002A.9040505@metafoo.de>
 <CAES_P+8p3-RdGRj70XjghKZP2NGUbd_+08LPgMU=xM5aca_6ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-112.synserver.de
 [212.40.185.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE9F261B17
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 08:40:34 +0100 (CET)
In-Reply-To: <CAES_P+8p3-RdGRj70XjghKZP2NGUbd_+08LPgMU=xM5aca_6ig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: noman pouigt <variksla@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/25/2013 11:57 PM, noman pouigt wrote:
> On Sun, Nov 24, 2013 at 11:45 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 11/25/2013 08:12 AM, noman pouigt wrote:
>>> Hello Lars,
>>>
>>> I was wondering if you can enlighten me
>>> on below query.
>>>
>>> Commit:ce6cfaf1
>>>
>>> From the commit text "The input and
>>> output paths for each widgets are only
>>> updated though during the respective run
>>> for that widget".
> Thanks for replying.Probably my query was
> not clear.I wanted to understand the commit
> text which i quoted above.And my understanding
> of that commit text is below:

The text just describes the behavior as it was before the commit, which was
separate power-up/power-down sequence for each widget.

>>> Does this commit text mean: when mux
>>> or mixer_power_update is called then only
>>> the widget is powered and it's peer- widget
>>> source(path source) and widget sink(path sink)?
>>
>> Hi,
>>
>> What the commit does is to make sure that if a control is shared between
>> multiple mixers/muxes to apply all the changes in the same update sequence.
>> Instead of, as it was done before, to run a update sequence for each mixer/mux.
> I understood this as you have clearly mentioned it with a nice
> diagram.
>>
>>>
>>>               +------+
>>>      A1 ------|      |
>>>               | MUX1 |----- C1
>>>      B1 ------|      |
>>>               +------+
>>>                  |
>>>       control ---+
>>>                  |
>>>               +------+
>>>      A2 ------|      |
>>>               | MUX2 |----- C2
>>>      B2 ------|      |
>>>               +------+
>>>
>>> Can I represent the above diagram as below:
>>>
>>> char *input_text_1[] = {
>>>         "A1", "B1"
>>> };
>>>
>>> struct soc_enum input_enum_1 =
>>>  SOC_ENUM_SINGLE(some_register, some_bit,
>>>                     2, input_text_1);
>>>
>>> char *input_text_2[] = {
>>>         "A2", "B2"
>>> };
>>> struct soc_enum input_enum_2 =
>>>  SOC_ENUM_SINGLE(some_register, some_bit,
>>>                   2, input_text_2);
>>>
>>>
>>> struct snd_kcontrol_new input_mux =
>>>    SOC_DAPM_ENUM("C1", input_enum_1);
>>> struct snd_kcontrol_new input_mux =
>>>    SOC_DAPM_ENUM("C2", input_enum_2);
>>>
>>> dapm_route[] {
>>> "A1", "control","C1"
>>> "B1", "control","C1"
>>> "A2", "control","C2"
>>> "B2", "control","C2"
>>> };
>>
>> The control part needs to have the name of one of the enum items. So this
>> would be { "A1", "A1", "C1" } and so on.
> Yes makes sense as then only it will know
> which widget to connect to as it has multiple
> widgets.
>>
>> - Lars
>>
>>
>>
>>
>>
