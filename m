From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Audio codec volume control
Date: Thu, 20 Sep 2012 13:19:01 +0300
Message-ID: <505AED95.20400@ti.com>
References: <505ACC37.3060209@st.com> <505AE8C6.3040001@ti.com>
 <505AEB19.7080205@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog135.obsmtp.com (na3sys009aog135.obsmtp.com
 [74.125.149.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A7E32264F2D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 12:18:07 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so1864834obb.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 03:18:05 -0700 (PDT)
In-Reply-To: <505AEB19.7080205@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/20/2012 01:08 PM, Rajeev kumar wrote:
>> case 3:
>> 1. Provide master volume control
>> 2. stereo volume control for the left/right channel
>>
> =

> You mean to say
> Left and Right should be a single stereo control which can be provided wi=
th
> SOC_DOUBLE. Actually case 2 corresponds to the same setting which you are
> suggesting.
> =

> But why this is better option?

You have less controls for the codec -> easier for users.
Users still can adjust the left/right differently if they want.

> In case user wants a separate left/right volume control then how this set=
ting
> is going to help.

In most cases you change both left/right channel:
amixer sset 'PCM' 8 # left/right volume is 8

but users can set different volume per channel:
amixer sset 'PCM' 8,1 # left volume is 8, right is 1

it is better than:
amixer sset 'PCM Left' 8 # left volume is 8
amixer sset 'PCM Right' 8 # left volume is 8

or
amixer sset 'PCM Left' 8 # left volume is 8
amixer sset 'PCM Right' 1 # left volume is 1

-- =

P=E9ter
