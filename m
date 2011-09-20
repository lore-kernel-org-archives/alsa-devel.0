From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: snd_pcm_hw_rule_noresample
Date: Tue, 20 Sep 2011 16:24:45 +0800
Message-ID: <CAN8cciYf2Jw_re57QrQ6D6dyn_3Ww3cfc5qdCp9Qv0O8Z6obsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174761c630bb3504ad5b31ad
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3695824433
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 10:24:46 +0200 (CEST)
Received: by fxe22 with SMTP id 22so305375fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2011 01:24:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

--0015174761c630bb3504ad5b31ad
Content-Type: text/plain; charset=ISO-8859-1

60fdc82f96bff2e3a31e9fcf8a9503f5a37c1f85

ALSA: pcm: add snd_pcm_hw_rule_noresample()

Add a helper function to allow drivers to disable hardware resampling
when the application has specified the SNDRV_PCM_HW_PARAMS_NORESAMPLE
flag.

Refer to commit and the three corresponding patch with ymfpci,
emu10k1, via82xx, it seem to be a regression

according to http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html


int snd_pcm_hw_params_set_rate_resample  	(  	snd_pcm_t *   	 pcm,
		snd_pcm_hw_params_t *  	params,
		unsigned int  	val	
	) 			

Restrict a configuration space to contain only real hardware rates.

ymfpci and emu10k1 have SNDRV_PCM_RATE_CONTINUOUS and support 8000Hz to 48000Hz


after this patch and if application using
snd_pcm_hw_params_set_rate_resample(,pcm , params ,0)

why the supported rate is only 48000Hz ?


but snd_pcm_hw_params_get_rate_min() is still 8000Hz


This patch won't affect the accuracy of the playback position of the ymfpci

attach a test program which print the the playback position and the result


 ./alsa_test hw:0
Hardware PCM card 0 'Yamaha DS-1 (YMF724F)' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16383
  period_size  : 5461
  period_time  : 123832
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 5461
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 16383
  silence_threshold: 0
  silence_size : 0
  boundary     : 2147352576
  appl_ptr     : 0
  hw_ptr       : 0
pcm write 5461
pcm write 5461
pcm write 5461
     0 0
     1 0
     2 0
     3 0
     4 0
     5 0
     6 0
     7 0
     8 0
     9 0
    10 0
    11 235
    12 235
    13 235
    14 235
    15 235
    16 470
    17 470
    18 470
    19 470
    20 470
    21 705
    22 705
    23 705
    24 705
    25 705
    26 940
    27 940
    28 940
    29 940
    30 940
    31 940
    32 1175
    33 1175
    34 1175
    35 1175
    36 1175
    37 1411
    38 1411
    39 1411
    40 1411
    41 1411
    42 1646
    43 1646
    44 1646
    45 1646
    46 1646
    47 1646
    48 1881
    49 1881
    50 1881
    51 1881
    52 1881
    53 2116
    54 2116
    55 2116
    56 2116
    57 2116
    58 2351
    59 2351
    60 2351
    61 2351
    62 2351
    63 2587
    64 2587
    65 2587
    66 2587
    67 2587
    68 2587
    69 2822
    70 2822
    71 2822
    72 2822
    73 2822
    74 3057
    75 3057
    76 3057
    77 3057
    78 3057
    79 3292
    80 3292
    81 3292
    82 3292
    83 3292
    84 3527
    85 3527
    86 3527
    87 3527
    88 3527
    89 3527
    90 3763
    91 3763
    92 3763
    93 3763
    94 3763
    95 3998
    96 3998
    97 3998
    98 3998
    99 3998
   100 4233
   101 4233
   102 4233
   103 4233
   104 4233
   105 4233
   106 4468
   107 4468
   108 4468
   109 4468
   110 4468
   111 4703
   112 4703
   113 4703
   114 4703
   115 4703
   116 4939
   117 4939
   118 4939
   119 4939
   120 4939
   121 5174
   122 5174
   123 5174
   124 5174
   125 5174
   126 5174
   127 5409
   128 5409
   129 5409
   130 5409
   131 5409
   132 5644
   133 5644
   134 5644
   135 5644
   136 5644
   137 5879
   138 5879
   139 5879
   140 5879
   141 5879
   142 6115
   143 6115
   144 6115
   145 6115
   146 6115
   147 6115
   148 6350
   149 6350
   150 6350
   151 6350
   152 6350
   153 6585
   154 6585
   155 6585
   156 6585
   157 6585
   158 6820
   159 6820
   160 6820
   161 6820
   162 6820
   163 6820
   164 7055
   165 7055
   166 7055
   167 7055
   168 7055
   169 7291
   170 7291
   171 7291
   172 7291
   173 7291
   174 7526
   175 7526
   176 7526
   177 7526
   178 7526
   179 7761
   180 7761
   181 7761
   182 7761
   183 7761
   184 7761
   185 7996
   186 7996
   187 7996
   188 7996
   189 7996
   190 8231
   191 8231
   192 8231
   193 8231
   194 8231
   195 8467
   196 8467
   197 8467
   198 8467
   199 8467
   200 8702
   201 8702
   202 8702
   203 8702
   204 8702
   205 8702
   206 8937
   207 8937
   208 8937
   209 8937
   210 8937
   211 9172
   212 9172
   213 9172
   214 9172
   215 9172
   216 9407
   217 9407
   218 9407
   219 9407
   220 9407
   221 9407
   222 9643
   223 9643
   224 9643
   225 9643
   226 9643
   227 9878
   228 9878
   229 9878
   230 9878
   231 9878
   232 10113
   233 10113
   234 10113
   235 10113
   236 10113
   237 10348
   238 10348
   239 10348
   240 10348
   241 10348
   242 10348
   243 10583
   244 10583
   245 10583
   246 10583
   247 10583
   248 10819
   249 10819
   250 10819
   251 10819
   252 10819
   253 11054
   254 11054
   255 11054
   256 11054
   257 11054
   258 11289
   259 11289
   260 11289
   261 11289
   262 11289
   263 11289
   264 11524
   265 11524
   266 11524
   267 11524
   268 11524
   269 11759
   270 11759
   271 11759
   272 11759
   273 11759
   274 11995
   275 11995
   276 11995
   277 11995
   278 11995
   279 11995
   280 12230
   281 12230
   282 12230
   283 12230
   284 12230
   285 12465
   286 12465
   287 12465
   288 12465
   289 12465
   290 12700
   291 12700
   292 12700
   293 12700
   294 12700
   295 12935
   296 12935
   297 12935
   298 12935
   299 12935
   300 12935
   301 13171
   302 13171
   303 13171
   304 13171
   305 13171
   306 13406
   307 13406
   308 13406
   309 13406
   310 13406
   311 13641
   312 13641
   313 13641
   314 13641
   315 13641
   316 13876
   317 13876
   318 13876
   319 13876
   320 13876
   321 13876
   322 14111
   323 14111
   324 14111
   325 14111
   326 14111
   327 14347
   328 14347
   329 14347
   330 14347
   331 14347
   332 14582
   333 14582
   334 14582
   335 14582
   336 14582
   337 14582
   338 14817
   339 14817
   340 14817
   341 14817
   342 14817
   343 15052
   344 15052
   345 15052
   346 15052
   347 15052
   348 15287
   349 15287
   350 15287
   351 15287
   352 15287
   353 15523
   354 15523
   355 15523
   356 15523
   357 15523
   358 15523
   359 15758
   360 15758
   361 15758
   362 15758
   363 15758
   364 15993
   365 15993
   366 15993
   367 15993
   368 15993
   369 16228
   370 16228
   371 16228
   372 16228
   373 16228
   374 -32

--0015174761c630bb3504ad5b31ad
Content-Type: text/x-csrc; charset=US-ASCII; name="alsa_test.c"
Content-Disposition: attachment; filename="alsa_test.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gssm7y6p0

I2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8YWxzYS9hc291
bmRsaWIuaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pIHsKICAgIGNvbnN0IGNo
YXIgKmRldjsKICAgIGludCBjYXAsIGVycjsKICAgIHNuZF9wY21faHdfcGFyYW1zX3QgKmh3cGFy
YW1zOwogICAgc25kX3BjbV9zd19wYXJhbXNfdCAqc3dwYXJhbXM7CiAgICBzbmRfcGNtX3N0YXR1
c190ICpzdGF0dXM7CiAgICBzbmRfcGNtX3QgKnBjbTsKICAgIHNuZF9vdXRwdXRfdCAqb3V0cHV0
ID0gTlVMTDsKCiAgICB1bnNpZ25lZCByYXRlOwogICAgdW5zaWduZWQgcGVyaW9kcyA9IDI7CiAg
ICB1bnNpZ25lZCBpbnQgdGhpc190aW1lLCBidWZmZXJfdGltZTsKICAgIGludCBzbGVlcF90aW1l
ID0gMTAwMDsKICAgIGludCBidWZmZXJbNjU1MzZdOwogICAgaW50IHN0YXRbNjU1MzZdOwogICAg
c25kX3BjbV91ZnJhbWVzX3QgYm91bmRhcnksIGJ1ZmZlcl9zaXplLCBwZXJpb2Rfc2l6ZSwgdGhp
c19wZXJpb2Q7CiAgICBpbnQgZGlyID0gMTsKICAgIGludCBpLCBjb3VudGVyOwogICAgc25kX3Bj
bV9zZnJhbWVzX3QgYXZhaWw7CgogICAgc25kX3BjbV9od19wYXJhbXNfYWxsb2NhKCZod3BhcmFt
cyk7CiAgICBzbmRfcGNtX3N3X3BhcmFtc19hbGxvY2EoJnN3cGFyYW1zKTsKCiAgICBkZXYgPSBh
cmdjID4gMSA/IGFyZ3ZbMV0gOiAiaHc6MCwwIjsKICAgIGNhcCA9IGFyZ2MgPiAyID8gYXRvaShh
cmd2WzJdKSA6IDA7CiAgICByYXRlID0gYXJnYyA+IDMgPyBhdG9pKGFyZ3ZbM10pIDogNDQxMDA7
CgogICAgZXJyID0gc25kX3BjbV9vcGVuKCZwY20sIGRldiwgY2FwID09IDAgPyBTTkRfUENNX1NU
UkVBTV9QTEFZQkFDSyA6IAoJCVNORF9QQ01fU1RSRUFNX0NBUFRVUkUsIDApOwogICAgaWYgKGVy
ciA8IDApIHsKCXByaW50Zigic25kX3BjbV9vcGVuIGZhaWwgJXMgZXJyICVzXG4iLGRldiwgc25k
X3N0cmVycm9yKGVycikpOwogICAgICAgIGV4aXQoMCk7CiAgICB9CgogICAgZXJyID0gc25kX3Bj
bV9od19wYXJhbXNfYW55KHBjbSwgaHdwYXJhbXMpOwovLyAgYXNzZXJ0KGVyciA9PSAwKTsKLyoK
ICAgIGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9yYXRlX3Jlc2FtcGxlKHBjbSwgaHdwYXJh
bXMsIDApOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKKi8KICAgIGVyciA9IHNuZF9wY21faHdfcGFy
YW1zX3NldF9hY2Nlc3MocGNtLCBod3BhcmFtcywgU05EX1BDTV9BQ0NFU1NfUldfSU5URVJMRUFW
RUQpOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKCiAgICBlcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19z
ZXRfZm9ybWF0KHBjbSwgaHdwYXJhbXMsIFNORF9QQ01fRk9STUFUX1MxNl9MRSk7CiAgICBhc3Nl
cnQoZXJyID09IDApOwoKICAgIGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9yYXRlX25lYXIo
cGNtLCBod3BhcmFtcywgJnJhdGUsIE5VTEwpOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKCiAgICBl
cnIgPSBzbmRfcGNtX2h3X3BhcmFtc19zZXRfY2hhbm5lbHMocGNtLCBod3BhcmFtcywgMik7CiAg
ICBhc3NlcnQoZXJyID09IDApOwovKgogICAgZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0X3Bl
cmlvZHNfaW50ZWdlcihwY20sIGh3cGFyYW1zKTsKICAgIGFzc2VydChlcnIgPT0gMCk7CiovCgog
ICAgZGlyID0gMDsKICAgIGVyciA9IHNuZF9wY21faHdfcGFyYW1zX3NldF9wZXJpb2RzX25lYXIo
cGNtLCBod3BhcmFtcywgJnBlcmlvZHMsICZkaXIpOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKCiAg
ICBidWZmZXJfc2l6ZSA9IHJhdGUgKiAyOwogICAgZXJyID0gc25kX3BjbV9od19wYXJhbXNfc2V0
X2J1ZmZlcl9zaXplX25lYXIocGNtLCBod3BhcmFtcywgJmJ1ZmZlcl9zaXplKTsKICAgIGFzc2Vy
dChlcnIgPT0gMCk7CgogICAgZXJyID0gc25kX3BjbV9od19wYXJhbXMocGNtLCBod3BhcmFtcyk7
CiAgICBhc3NlcnQoZXJyID09IDApOwoKICAgIGVyciA9IHNuZF9wY21faHdfcGFyYW1zX2N1cnJl
bnQocGNtLCBod3BhcmFtcyk7CiAgICBhc3NlcnQoZXJyID09IDApOwoKICAgIGVyciA9IHNuZF9w
Y21fc3dfcGFyYW1zX2N1cnJlbnQocGNtLCBzd3BhcmFtcyk7CiAgICBhc3NlcnQoZXJyID09IDAp
OwoKLyoKICAgIGlmIChjYXAgPT0gMCkKICAgICAgZXJyID0gc25kX3BjbV9zd19wYXJhbXNfc2V0
X2F2YWlsX21pbihwY20sIHN3cGFyYW1zLCAxKTsKICAgIGVsc2UKICAgICAgZXJyID0gc25kX3Bj
bV9zd19wYXJhbXNfc2V0X2F2YWlsX21pbihwY20sIHN3cGFyYW1zLCAwKTsKICAgIGFzc2VydChl
cnIgPT0gMCk7CiovCi8qCiAgICBlcnIgPSBzbmRfcGNtX3N3X3BhcmFtc19zZXRfcGVyaW9kX2V2
ZW50KHBjbSwgc3dwYXJhbXMsIDApOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKKi8KICAgIGVyciA9
IHNuZF9wY21faHdfcGFyYW1zX2dldF9idWZmZXJfc2l6ZShod3BhcmFtcywgJmJ1ZmZlcl9zaXpl
KTsKICAgIGFzc2VydChlcnIgPT0gMCk7Ci8qCiAgICBlcnIgPSBzbmRfcGNtX2h3X3BhcmFtc19n
ZXRfYnVmZmVyX3RpbWUoaHdwYXJhbXMsICZidWZmZXJfdGltZSwgMCk7CiAgICBhc3NlcnQoZXJy
ID09IDApOwoqLwogICAgZXJyID0gc25kX3BjbV9od19wYXJhbXNfZ2V0X3BlcmlvZF9zaXplKGh3
cGFyYW1zLCAmcGVyaW9kX3NpemUsIDApOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKLyoKICAgIGVy
ciA9IHNuZF9wY21fc3dfcGFyYW1zX3NldF9zdGFydF90aHJlc2hvbGQocGNtLCBzd3BhcmFtcywg
YnVmZmVyX3NpemUpOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKCiAgICBlcnIgPSBzbmRfcGNtX3N3
X3BhcmFtc19nZXRfYm91bmRhcnkoc3dwYXJhbXMsICZib3VuZGFyeSk7CiAgICBhc3NlcnQoZXJy
ID09IDApOwoKICAgIGVyciA9IHNuZF9wY21fc3dfcGFyYW1zX3NldF9zdG9wX3RocmVzaG9sZChw
Y20sIHN3cGFyYW1zLCBidWZmZXJfc2l6ZSk7CiAgICBhc3NlcnQoZXJyID09IDApOwoqLwogICAg
ZXJyID0gc25kX3BjbV9zd19wYXJhbXNfc2V0X3RzdGFtcF9tb2RlKHBjbSwgc3dwYXJhbXMsIFNO
RF9QQ01fVFNUQU1QX0VOQUJMRSk7CiAgICBhc3NlcnQoZXJyID09IDApOwoKICAgIGVyciA9IHNu
ZF9wY21fc3dfcGFyYW1zKHBjbSwgc3dwYXJhbXMpOwogICAgYXNzZXJ0KGVyciA9PSAwKTsKCgog
ICAgZXJyID0gc25kX3BjbV9zd19wYXJhbXNfY3VycmVudChwY20sIHN3cGFyYW1zKTsKICAgIGFz
c2VydChlcnIgPT0gMCk7CgogICAgZXJyID0gc25kX291dHB1dF9zdGRpb19hdHRhY2goJm91dHB1
dCwgc3Rkb3V0LCAwKTsKICAgIGlmIChlcnIgPCAwKSAKCXByaW50ZigiT3V0cHV0IGZhaWxlZDog
JXNcbiIsIHNuZF9zdHJlcnJvcihlcnIpKTsKICAgIHNuZF9wY21fZHVtcChwY20sIG91dHB1dCk7
CgovKiAgICAgYXNzZXJ0KHNuZF9wY21faHdfcGFyYW1zX2lzX21vbm90b25pYyhod3BhcmFtcykg
PiAwKTsgKi8KCgogICAgaWYgKGNhcCkgewogICAgICBlcnIgPSBzbmRfcGNtX3N0YXJ0KHBjbSk7
CiAgICAgIGFzc2VydChlcnIgPT0gMCk7CiAgICB9CiAgICBlbHNlIHsKICAgICAgICB0aGlzX3Bl
cmlvZCA9IDA7CiAgICAgICAgd2hpbGUgKHRoaXNfcGVyaW9kPGJ1ZmZlcl9zaXplKSB7CiAgICAg
ICAgICAgIGVyciA9IHNuZF9wY21fd3JpdGVpKHBjbSwgYnVmZmVyLCBwZXJpb2Rfc2l6ZSk7Cgkg
ICAgcHJpbnRmKCJwY20gd3JpdGUgJWRcbiIsZXJyKTsKICAgICAgICAgICAgdGhpc19wZXJpb2Qg
Kz0gcGVyaW9kX3NpemU7Cgl9OwogICAgfTsKCiAgICBhdmFpbD0wOwogICAgdGhpc190aW1lID0w
OwogICAgY291bnRlciA9IDA7Ci8vICBwcmludGYoImJ1ZmZlciB0aW1lICVkXG4iLGJ1ZmZlcl90
aW1lKTsKICAgIHdoaWxlIChjb3VudGVyIDwgMzI3NjcgJiYgYXZhaWwgPj0gMCkgewogICAgICAg
IGF2YWlsID0gc25kX3BjbV9hdmFpbChwY20pOwogICAgICAgIHN0YXRbY291bnRlcl0gPSBhdmFp
bDsKICAgICAgICB1c2xlZXAoc2xlZXBfdGltZSk7CiAgICAgICAgY291bnRlcisrOwogICAgICAg
IHRoaXNfdGltZSArPSBzbGVlcF90aW1lOwogICAgfTsKICAgIGZvciAoaT0wOyBpPGNvdW50ZXI7
IGkrKykgCiAgICAgICAgcHJpbnRmKCIlNmQgJWRcbiIsaSwgc3RhdFtpXSk7CgogICAgc25kX3Bj
bV9jbG9zZShwY20pOwogICAgcmV0dXJuIDA7Cn0K
--0015174761c630bb3504ad5b31ad
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174761c630bb3504ad5b31ad--
