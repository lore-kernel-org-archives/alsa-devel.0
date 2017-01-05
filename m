From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] Revert "ALSA: firewire-lib: change
 structure member with proper type"
Date: Thu, 5 Jan 2017 16:14:22 +0900
Message-ID: <0a0c02ab-44e0-eaac-b274-ff8796c0d4d9@sakamocchi.jp>
References: <20170105004131.19202-1-o-takashi@sakamocchi.jp>
 <s5ha8b6ow0y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id E1797266F78
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 08:14:25 +0100 (CET)
In-Reply-To: <s5ha8b6ow0y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Jan 5 2017 15:34, Takashi Iwai wrote:
> On Thu, 05 Jan 2017 01:41:31 +0100,
> Takashi Sakamoto wrote:
>>
>> This reverts commit 6b7e95d1336b9eb0d4c6db190ce756480496bd13. This commit
>> is based on a concern about value of the given parameter. It's expected
>> to be ORed value with some enumeration-constants, thus often it can not be
>> one of the enumeration-constants. I understood that this is out of
>> specification and causes implementation-dependent issues.
>>
>> In C language specification, enumerated type can be interpreted as an
>> integer type, in which all of enumeration-constants in corresponding
>> enumerator-list can be stored. Implementations can select one of char,
>> signed int and unsigned int as its type, and this selection is
>> implementation-dependent.
>>
>> In GCC, a signed integer is selected when at least one of
>> enumeration-constants has negative value, else an unsigned integer is
>> selected. This behaviour can be switched by -fshort-enums to short type.
>> Anyway, the type can be decided after scanning all of
>> enumeration-constants.
>>
>> Totally, there's no rules to constrain the value of enumerated type to
>> be one of enumeration-constants. In short, in enumerated type, decision
>> of actual type for the type is the most important and
>> enumeration-constants are just used for the decision, thus it's permitted
>> to have an integer value in a range of enumeration-constants. In our case,
>> actual type for the type is currently deterministic to be either char or
>> unsigned int. Under GCC, it's unsigned int.
>
> You sign-off is missing.

Oops...

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Should I re-post this with the sign-off?


Thanks

Takashi Sakamoto
