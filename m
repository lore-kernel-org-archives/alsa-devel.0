From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [Patch V7 02/10] ASoC: qcom: Document LPASS CPU bindings
Date: Fri, 6 Mar 2015 16:06:48 -0600
Message-ID: <37AEDC0C-448D-4F3A-B87D-C37B9F2D8E1B@codeaurora.org>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org> <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org> <7E5AFC65-1705-4BDC-B57F-0444E83A8987@codeaurora.org> <20150306015131.GA15850@kwestfie-linux.qualcomm.com> <D5A5C916-4D40-4C51-8307-9CA90FC68347@codeaurora.org> <20150306220342.GA25363@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150306220342.GA25363@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


On Mar 6, 2015, at 4:03 PM, Kenneth Westfield <kwestfie@codeaurora.org>=
 wrote:

> On Fri, Mar 06, 2015 at 10:07:01AM -0600, Kumar Gala wrote:
>> On Mar 5, 2015, at 7:51 PM, Kenneth Westfield <kwestfie@codeaurora.o=
rg> wrote:
>>> On Thu, Mar 05, 2015 at 12:52:30PM -0600, Kumar Gala wrote:
>>>> On Mar 3, 2015, at 6:21 PM, Kenneth Westfield <kwestfie@codeaurora=
=2Eorg> wrote:
>>>>=20
>>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
>>>>> @@ -0,0 +1,49 @@
>>>>> +* Qualcomm Technologies LPASS CPU DAI
>>>>> +
>>>>> +Required subnodes:
>>>>> +
>>>>> +- qcom,adsp		: Audio DSP sub-node
>>>>> +
>>>>> +Optional Audio DSP subnode properties:
>>>>> +
>>>>> +- status		: "disabled" indicates the adsp is not available.
>>>>> +
>>>>=20
>>>> What is the intent of this subnode?
>>>>=20
>>>=20
>>> From the cover letter:
>>> Even though the ipq806x LPASS does not contain an audio DSP, other =
SOCs
>>> do have one.  For those SOCs, the audio DSP typically controls the
>>> hardware blocks in the LPASS.  Hence, different CPU DAI driver(s) w=
ould
>>> need to be used in order to facilitate audio with the DSP.  As such=
, the
>>> LPASS DT contains an adsp subnode, which is disabled for this SOC. =
 The
>>> same subnode should be enabled and populated for other SOCs that do
>>> contain an audio DSP.  Not using the audio DSP would require differ=
ent
>>> CPU DAI driver(s), in addition to possible bootloader and/or firmwa=
re
>>> changes.
>>>=20
>>> This was the result of a request from Mark.  See here:
>>> http://thread.gmane.org/gmane.linux.drivers.devicetree/109331/focus=
=3D11633
>>=20
>> Two quick comments before I read Mark?s comments.
>>=20
>> 1. Its not normal practice to put something into a DT that does not =
exist.  Having a node, but marking it disabled implies existence.
>=20
> Will change the DT definition to optional.
>=20
>> 2. How would one normally address the audio DSP if it did exist.  I?=
m just wondering if having a subnode is the proper solution vs maybe a =
phandle
>=20
> The audio DSP is, in fact, contained within the audio subsystem.  The
> representation of that relationship in the DT, I believe, would be a =
subnode.
> OTOH, if there is a strong sentiment towards using a phandle, that wo=
uld be
> fine with me.

Just depends on how we communicate with the DSP.  If its mostly via MMI=
O access than a sub node makes sense.  If its via some other RPC/commun=
ication mechanism than possibly a phandle.  Trying to understand a bit =
more to than see what I=92d recommend.

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
