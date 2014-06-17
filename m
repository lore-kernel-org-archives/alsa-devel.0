From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: Re:
 =?utf-8?q?alsa-lib=3A_pcm=5Fplug=3A_fix_float_conver?=
 =?utf-8?q?sion_for_user_specified_ttable?=
Date: Tue, 17 Jun 2014 20:19:43 +0400
Message-ID: <1403021983.990267259@f229.i.mail.ru>
References: <1402933971.835286264@f359.i.mail.ru>
 <CAN8cciZvcjLTyOFSB-=Ret7FrG7ASGbkJSNo0xRVOZF7+et4sg@mail.gmail.com>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f229.i.mail.ru (f229.i.mail.ru [217.69.138.229])
 by alsa0.perex.cz (Postfix) with ESMTP id 845B6265489
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 18:19:44 +0200 (CEST)
In-Reply-To: <CAN8cciZvcjLTyOFSB-=Ret7FrG7ASGbkJSNo0xRVOZF7+et4sg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
Cc: =?UTF-8?B?UmF5bW9uZCBZYXU=?= <superquad.vortex2@gmail.com>
List-Id: alsa-devel@alsa-project.org

June 17 2014 Raymond Yau wrote:

>> Move custom ttable with equal channels case from a separate ttable_last
>> exception into a common plugins insertion loop.
>> Fixes plug with ttable for float pcms (jack, ladspa).
>> Example: aplay -fFLOAT_LE /dev/zero
>> pcm.!default {
>>     type plug
>>     slave.pcm { type null }
>>     ttable.0.0 1
>> }
> 
> Any reason to use type null in your test case since type null seem can
> support all format ?

It was the shortest test to reproduce the bug.

A more restricted config:
# aplay -fFLOAT_LE /dev/zero
pcm.!default {
    type plug
    slave.pcm { type null }
    slave.format FLOAT_LE
    ttable.0.0 1
}
But that test was enough to reproduce "Assertion failed" bug too.

Actually I've hit this bug with a complex ladspa upmixing code:
pcm.upmix {
    type plug
    slave.pcm {
        type ladspa
        slave.pcm {
            type plug
            slave.pcm "..."
            ttable { ... }
        }
        plugins [ ... ]
    }
    ttable { ... }
}
similar to this:
  http://forums.gentoo.org/viewtopic-p-4528619.html#4528619

This bug crashed the application for me (it generates SIGABRT)
so I thought that it should be fixed.

-- 
  Sergey
