From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: EWX 24/96 and SPDIF: solved? (with patch)
Date: Tue, 30 Sep 2003 09:24:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_2412589==_"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--=====================_2412589==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

Hello Jaroslav and Takashi,

may be I finally nailed down the SPDIF problem with the TerraTec EWX 24/96. 
The problem is caused by the execution of a second CS8427 reset in the 
snd_cs8427_iec958_pcm() function in the cs8427.c file, exactly in the 
following lines of code:

...
reset = chip->rate != rate;
snd_i2c_unlock(cs8427->bus);
if (reset)
	snd_cs8427_reset(cs8427);
...

Anyway, I think the problem arise elsewhere, within the ice1712.c file, in 
the snd_ice1712_playback_pro_hw_params(), where there are the following 
lines of code:

...
if (ice->spdif.ops.setup_rate)
	ice->spdif.ops.setup_rate(ice, params_rate(hw_params));
...

where the spdif rate is changed without checking if the rate is locked or 
not, i.e. without verifying if the is_pro_rate_locked() function returns 
true. Attached to this e-mail there's the obvious patch for this problem, 
changing the previous line into:

...
if (ice->spdif.ops.setup_rate && !is_pro_rate_locked(ice))
	ice->spdif.ops.setup_rate(ice, params_rate(hw_params));
...

With this patch my EWX works flawless with ALSA 0.9.7, anyway I can't check 
if it is going to cause problems with other ICE1712 based soundcards. I 
hope this change is the right one, and not something that makes just my 
soundcard work.

Bye,
--=====================_2412589==_
Content-Type: application/octet-stream; name="ice1712.dif";
 x-mac-type="42494E41"; x-mac-creator="5843454C"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ice1712.dif"

LS0tIGljZTE3MTIuYy5vcmlnICAgICAgU3VuIFNlcCAyOCAwMjoxNzo1NSAyMDAzCisrKyBpY2Ux
NzEyLmMgICBTdW4gU2VwIDI4IDAyOjE3OjQ3IDIwMDMKQEAgLTEwNzIsNyArMTA3Miw3IEBACiAg
ICAgICAgaWNlMTcxMl90ICppY2UgPSBzbmRfcGNtX3N1YnN0cmVhbV9jaGlwKHN1YnN0cmVhbSk7
CgogICAgICAgIHNuZF9pY2UxNzEyX3NldF9wcm9fcmF0ZShpY2UsIHBhcmFtc19yYXRlKGh3X3Bh
cmFtcyksIDApOwotICAgICAgIGlmIChpY2UtPnNwZGlmLm9wcy5zZXR1cF9yYXRlKQorICAgICAg
IGlmIChpY2UtPnNwZGlmLm9wcy5zZXR1cF9yYXRlICYmICFpc19wcm9fcmF0ZV9sb2NrZWQoaWNl
KSkKICAgICAgICAgICAgICAgIGljZS0+c3BkaWYub3BzLnNldHVwX3JhdGUoaWNlLCBwYXJhbXNf
cmF0ZShod19wYXJhbXMpKTsKICAgICAgICByZXR1cm4gc25kX3BjbV9saWJfbWFsbG9jX3BhZ2Vz
KHN1YnN0cmVhbSwgcGFyYW1zX2J1ZmZlcl9ieXRlcyhod19wYXJhbXMKKSk7CiB9
--=====================_2412589==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it
--=====================_2412589==_--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
