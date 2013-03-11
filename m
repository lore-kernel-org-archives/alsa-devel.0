From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: twl4030 and Puredata/jack
Date: Mon, 11 Mar 2013 14:45:40 +0100
Message-ID: <513DE004.2060305@ti.com>
References: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C84126503E
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 14:45:47 +0100 (CET)
In-Reply-To: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anders Alex <alibobar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/08/2013 04:31 PM, Anders Alex wrote:
> With 'jackd -d alsa -S'  (need s16_le):

I'm not really a jack user, but can you try:
jackd -d alsa -o 2 -i 2 -S -C hw:0,1 -P hw:0,0

So you tell jack to play on hw:0,0 record on hw:0,1 use stereo for both.



-- =

P=E9ter
