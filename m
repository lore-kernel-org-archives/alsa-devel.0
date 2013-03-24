From: xiphmont@xiph.org
Subject: Re: [alsa-devel] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 14:00:23 -0400
Message-ID: <CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
	<50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
	<50F7F23C.4070006@gmail.com>
	<CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
	<514F36F6.8080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <vorbis-dev-bounces@xiph.org>
In-Reply-To: <514F36F6.8080806@gmail.com>
List-Unsubscribe: <http://lists.xiph.org/mailman/listinfo/vorbis-dev>,
	<mailto:vorbis-dev-request@xiph.org?subject=unsubscribe>
List-Archive: <http://lists.xiph.org/pipermail/vorbis-dev>
List-Post: <mailto:vorbis-dev@xiph.org>
List-Help: <mailto:vorbis-dev-request@xiph.org?subject=help>
List-Subscribe: <http://lists.xiph.org/mailman/listinfo/vorbis-dev>,
	<mailto:vorbis-dev-request@xiph.org?subject=subscribe>
Sender: vorbis-dev-bounces@xiph.org
Errors-To: vorbis-dev-bounces@xiph.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> The only thing I personally had an actual issue with is using "front" for
> stereo rather than "default". I don't seem able to come up with a compelling
> reason why it should be "front" myself, so one tweak could perhaps be to
> only change the stereo device back to "default"?

Because then you can't guarantee or even discover what the playback
rate and bitdepth are. There's no way to ensure bit-exact playback in
a plug device, where 'front' is usually a non-plug alias.

Like I said, I agree the current situation sucks, and I don't mean to
discourage suggestions :-)

Monty
