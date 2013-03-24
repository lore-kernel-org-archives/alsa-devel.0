From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Vorbis-dev] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 19:50:52 +0100
Message-ID: <514F4B0C.8020309@ladisch.de>
References: <50F6FF00.7020706@gmail.com>	<50F71312.1000009@ladisch.de>	<50F7D0E3.3020401@gmail.com>	<50F7EAA1.7040504@ladisch.de>	<50F7F23C.4070006@gmail.com>	<CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>	<514F36F6.8080806@gmail.com>
 <CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 50B802602C6
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 19:52:21 +0100 (CET)
In-Reply-To: <CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiphmont@xiph.org
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

xiphmont@xiph.org wrote:
>> The only thing I personally had an actual issue with is using "front" for
>> stereo rather than "default". I don't seem able to come up with a compelling
>> reason why it should be "front" myself, so one tweak could perhaps be to
>> only change the stereo device back to "default"?
>
> Because then you can't guarantee or even discover what the playback
> rate and bitdepth are. There's no way to ensure bit-exact playback in
> a plug device, where 'front' is usually a non-plug alias.

The SND_PCM_NO_AUTO_* flags are there for exactly this reason:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga64fa40b556374dabe40d4874242fee19


Regards,
Clemens
