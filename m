From: =?windows-1252?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: PowerMac 11,2 topaz digital-in
Date: Sun, 21 May 2017 16:33:21 +0200
Message-ID: <9F610D2B-FFC7-45DC-89DD-C6ED90D00BE1@exactcode.de>
References: <4D425EDE-3FF5-4895-B469-58977B887FAC@exactcode.de>
 <C4DF4DD1-F0E9-4537-B68E-6635FD8902E6@exactcode.de>
 <55213C5F-29CA-49C6-AE16-283BAE9534DF@exactcode.de>
 <s5ho9vpmygb.wl-tiwai@suse.de>
 <0F0E6DC8-D7B8-4EF9-BD47-8AAC124E3665@exactcode.de>
 <6FF6B7F4-9C39-4E3C-BB79-D47507DE6C11@exactcode.de>
 <12E027DF-A28D-436C-97E6-6AF0E5EF699D@exactcode.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
 by alsa0.perex.cz (Postfix) with ESMTP id CBD7D266C41
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 16:33:27 +0200 (CEST)
In-Reply-To: <12E027DF-A28D-436C-97E6-6AF0E5EF699D@exactcode.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Johannes Berg <johannes@sipsolutions.net>
List-Id: alsa-devel@alsa-project.org

Hi there,

I noticed digital input would not show up at all on my PowerMac G5 11,2, I =
see this in dmesg:

[   15.719952] snd-aoa-fabric-layout: Using PMF GPIOs
[   15.720519] snd-aoa-fabric-layout: can use this codec
[   15.760567] snd-aoa-codec-onyx: attached to onyx codec via i2c
[   15.760745] snd-aoa-fabric-layout: platform-onyx-codec-ref doesn't match!
[   15.760748] snd-aoa: fabric didn't like codec onyx

and poking around a bit more I found a =93topaz=94 codec apparently some Cr=
ystal
Semiconductor CS84xx =93Topaz=94 (S/PDIF digital input) showing up nowhere
in the ALSA sources.

Am I overlooking something, or was this lost in merging? Any hint would be
appreciated.

	Ren=E9
-- =

 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t=
2-project.org | http://rene.rebe.de
