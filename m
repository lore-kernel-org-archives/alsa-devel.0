From: The Source <thesourcehim@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Wed, 15 Oct 2008 12:14:57 +0400
Message-ID: <48F5A681.8050609@gmail.com>
References: <20081012165353.a084d158.baz@irc.msk.ru>	<s5hod1pz1xl.wl%tiwai@suse.de>	<20081013165805.735bf06e.baz@irc.msk.ru>	<s5htzbg63bq.wl%tiwai@suse.de>	<48F35C4C.40307@gmail.com>	<s5hej2k5ysj.wl%tiwai@suse.de>	<s5hbpxo5wmw.wl%tiwai@suse.de>	<s5h1vyk5vr3.wl%tiwai@suse.de>	<s5hy70s4h0i.wl%tiwai@suse.de>	<20081013232147.026f38c9.baz@irc.msk.ru>	<s5hzll7oetb.wl%tiwai@suse.de>	<48F463AC.1000307@gmail.com>	<s5hhc7f4fec.wl%tiwai@suse.de>	<48F48166.4030908@gmail.com>	<s5hd4i2z7k6.wl%tiwai@suse.de>	<48F598D0.3070700@gmail.com>	<s5h63nuz4vl.wl%tiwai@suse.de>	<48F59FF4.20800@gmail.com>
	<s5h4p3ez41h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010305000703040709010004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E446A1037F3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 10:17:45 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1773517nfd.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2008 01:17:28 -0700 (PDT)
In-Reply-To: <s5h4p3ez41h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010305000703040709010004
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> At Wed, 15 Oct 2008 11:47:00 +0400,
> The Source wrote:
>  =20
>> Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>    =20
>>> At Wed, 15 Oct 2008 11:16:32 +0400,
>>> The Source wrote:
>>>  =20
>>>      =20
>>>> Takashi Iwai =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>    =20
>>>>        =20
>>>>> At Tue, 14 Oct 2008 15:24:22 +0400,
>>>>> The Source wrote:
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>>>> By the way, note, that not rate may cause oops but number of chann=
les=20
>>>>>> for example (wav that causes oops has mono mode and the one that j=
ust=20
>>>>>> plays silently - stereo. Also the oops sample is 16bit, silent one=
 is=20
>>>>>> 24bit).
>>>>>>    =20
>>>>>>        =20
>>>>>>            =20
>>>>> This is an important information.  The driver basically supports on=
ly
>>>>> 16bit stereo samples natively.  The others are covered by alsa-lib,
>>>>> and this involves with the mmap mode.
>>>>>
>>>>> But I still wonder why 16bit mode.
>>>>>
>>>>> OK, the below is *THE* test I'd like ask you guys to try first.
>>>>>
>>>>> - Build the driver with --with-debug=3Ddetect option
>>>>> - Load the driver with debug=3D2 module option
>>>>> - Prepare a WAV file with 96kHz 16bit stereo, e.g. converted via so=
x
>>>>> - Raise the Master volume to the max
>>>>> - Run "aplay this.wav"
>>>>>
>>>>> At *each* run, check your kernel message.  If you get Oops, copy th=
e
>>>>> whole log immediately.
>>>>>
>>>>> - If you get a DMA error or so in the kernel message, try to define
>>>>>   XXX_SYSTEM_TIMER in sbxfi.c, rebuild and reinstall the driver.
>>>>>   Run the same test.
>>>>>
>>>>> - If still any serious problem, load the module with debug=3D3 opti=
on,
>>>>>   and get the whole kernel message with full register accesses.
>>>>>
>>>>>
>>>>> thanks,
>>>>>
>>>>> Takashi
>>>>>
>>>>>  =20
>>>>>      =20
>>>>>          =20
>>>> I've done what you have asked. I've got no oopses or other things li=
ke=20
>>>> that. But again not sound. I've tried with debug=3D2 and debug=3D3.=20
>>>> Attaching the whole dmesg output.
>>>>    =20
>>>>        =20
>>> Thanks.  Judging from your logs, it seems that the timer IRQ isn't
>>> generated as expected, or the pointer (SRCCA register read) doesn't
>>> work, or all broken.
>>>
>>> Could you try with XXX_SYSTEM_TIMER?  This eliminates, at least, the
>>> timer issue.
>>>
>>>
>>> Takashi
>>>
>>>  =20
>>>      =20
>> I can't use system timer. changing #undef XXX_SYSTEM_TIMER to #define=20
>> XXX_SYSTEM_TIMER causes this:
>> In file included from /mnt/e/temp/alsa-driver-unstable/pci/sbxfi/sbxfi=
.c:2:
>> /mnt/e/temp/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxf=
i.c:=20
>> In function =E2=80=98sbxfi_timer_handle=E2=80=99:
>> /mnt/e/temp/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxf=
i.c:252:=20
>> error: =E2=80=98status=E2=80=99 undeclared (first use in this function=
)
>> /mnt/e/temp/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxf=
i.c:252:=20
>> error: (Each undeclared identifier is reported only once
>> /mnt/e/temp/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxf=
i.c:252:=20
>> error: for each function it appears in.)
>> /mnt/e/temp/alsa-driver-unstable/include/../alsa-kernel/pci/sbxfi/sbxf=
i.c:252:=20
>> warning: too many arguments for format
>>    =20
>
> Try the patch below.  In case you're using snapshot tarball, apply it
> with -p2 on alsa-kernel directory.
>
>
> Takashi
>
> diff --git a/sound/pci/sbxfi/sbxfi.c b/sound/pci/sbxfi/sbxfi.c
> index 9ff5fc4..d6b5b34 100644
> --- a/sound/pci/sbxfi/sbxfi.c
> +++ b/sound/pci/sbxfi/sbxfi.c
> @@ -249,7 +249,7 @@ static void sbxfi_handle_timer_callback(struct sbxf=
i *chip);
> =20
>  static void sbxfi_timer_handle(unsigned long data)
>  {
> -	LOG(2, "TIMER ISR\n", status);
> +	LOG(2, "TIMER ISR\n");
>  	sbxfi_handle_timer_callback((struct sbxfi *)data);
>  }
> =20
>
>
>  =20
Ok, I tested again and found that sound is actually played (with and=20
without system timer), but:
1. The volume is extremely low. I had not only set volume to maximum in =20
alsamixer but also set my audio 5.1 system volume to maximum to hear a=20
sound.
2. The sound is very slow and glitchy. It plays much slower that it=20
should and constant glitches occur.

Attaching dmesg output.


--------------010305000703040709010004
Content-Type: application/x-bzip;
 name="dmesg.out.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.bz2"

QlpoOTFBWSZTWadsTskANKHfgEAQQGP/8r+v/mC/r9/gYCF8AAD3gDwDgAAgHOQD6mkXvPne
KIFelPpldoj585yC9cAnSHa887r0iUl55zpJSHcwDl8AXUumAQlrouYwCVUnlBpqe/P1VSqe
kH6oAAAAAABkTPb9RVUzVP/UqAAAAAAAADVPZqESqnlPyVDATQAaBgCZAAlT/VFTRJpNQyYB
NBkMCPUyYEABSlETI0DRI1PRtTZU9R+mqfqmh+qbR6pp6RtQJTIgU2jSkSn6p6mgABpo0GgA
Hs+jn9XOfK9fq/RvX9s57fl6/c93fX3vP3PRoAAAAAABIAEgAAAAAAAAAASAASAAAAAAAAAA
AAAAAABHn7G2gEgAAAAAASAEgAAAAAAAAAQ6YEgAAAAAAAAEgAAAEgAAAEgRnW6AAAAAAAAA
AAASAAAAAAAAF7uZ73p3QAAAAAAAAAAAJAAAAAAAkCN9W7IAAAAAAAFu+xvLlz23LHK5zFzp
yuczJz82kVrk6uGkVrk6uGkVrk2c2krp9NPOvPPPEvftnxwAAAAAD5ALMALAAAAAAAAAPqAW
H0ALAAAAAAAAAAAAAAAAANALAAAAAMAL4AWAAAAAH8oBYAGAFgAAAAAABoBYAAfYAsAAOgFg
AAAAAAAAAAAHACwAAAAAAAAAAAAAAAAAAAsAsAAAAAwAvQCwAAAAAD6r7OBnzmMky817u7u7
u7ugAAAAAMzMzTMzMAAAAAAAAMzMxrWtaAAAAAAAAGZmY1rWtAAAAAAAADMzMa1rWgAAAAAA
ABmZmNa1rQAAAAAAAAzMzGta1oAAAs5+d/Hhxy5cuXHHLv258dunTwszZJJJJJJJJJJJbmSS
S3MkkkkkkkkkkkkkkkkszJJJLMySSSSSSSSSSSSSSSSSSSSSSSSSc3KySW5kkkkkkkkkklmZ
JJZmSSSSSSSSSSSSSSScUluZJJJJJJJJJJJJJLcySSSSSSzMkkkkkkszJJxSSSSSSSSSSSSS
SSSSSS3Mkkkkkkkkkkkkluc22ySSSSSSSSSSSSSSSSSW5kkkkkkkkkklmZJOKzMkkkkkkkkk
kknGW6m7zy8vL1du3bsAAO4FoFAAAAeIAAgAAAAAAADyAQABQeZQUAAAA2AgAABQEB2AQHkA
gAAAAAeiAgAAAAAAAAB4gIAA8QeKgoA3bt27du3dfD76Qh7aQh9F8F4ft2d9Se5kZIpYZIiZ
VRS5MBF376+8396SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSP8S+74vPPPPFdKhZgGM
klgf2KrMgZkDMQZgGZSykLMqJaGVRLZSi0P70ou7jmFRcFlVVHRt0ylF6fL0pRbfyeW/n2LO
38ftXf0L+EqqM7F6rVUK5bvgpZmVBWUostF5rhKVLxxVF4l0rzXmtniuUv2Wxfqu1c62luvr
g7svhkEvHKla4iGxmBMfZjdkqLbr4bu3y5vHY8vZf59sUaO9mLTg6/T85nz+vrnfnOc/TznO
MCVBERARmUSXs7PxpCGw4qUW7TSqi7GYj99w/LIygAiCPciHX3iCICNb++ErL75J+ObZznCb
OgKAiICEBEEEfCbfJtnQ7rk6+ZytwpNHb56qrFmdpOnFDZt7ne023dTOsS6xd4ookvl3Ej7n
R9z7n3PuZOGzw5ssWUQRAQ7bqmVy1g41TpFiXeeXvfOmmk0+zt8WIuMvucxPzt2ZxrJUu4pL
UbzdvndpxtqdNpTivFUj2mqiN6SPt52kYS8slL7Wjb7Oe89cHSjN4rgsKV3eO1VUkIV7ttki
EJHp6enp6enp0bNmzcWs98SnXTGZsk1kky1jMtkns1zjlxxxxy5cd/Lq598TzZneySSeNttt
tkkkklttttttskkkkttttttttkkkpLrPbr7+3jx38ePAAAbu7u7uZmZjMzjjjv37szMzMbu7
u7u7mZmZjd3d3W7u7vX09PKrp0CCPEW8x3fzwzfH5F5WUrXx9MndYmdYz1arJM7mPKleZRX3
Osr1ce63SqvLpZbRb7S1WridV1uvJj9pYraleK7T8KXPXmMrVnOrY/ee5uXlU1nFV7KpLa5Q
sfl5TVV49d1cfnLvJ0YMCPTv09Po+jh0bOzw2WLLyUUolSr219VSK+KKdOs+CbbSPnZ5FxTv
vOe59i82STqutzkS5WccVbU/kXj5XOPrfi5SKVRxe80W1KXtFZH5zjFW0vHbV2/PpjX01ajd
Pph7fEzM5pWSbFlxhJZhQZtaT4ovp4VpcSdZ+ZxpVglBpBkm02QdKV8lyizZrpmTrWMdW6z8
vjrqX1FlKF8eEJaFlaSTV0ruyi6PiiToQXx86mZm0EBEEWI+x9j7H2PsfY7OHZ2dnZa3Ydig
gICBGMYxMzNAVVVMzNBwqs5McTcF8uyayIvd/WnAiWMRUvVmXLWzP17vu++yST1Y3dejlKtI
nXVSu01dednknmIvRmZUjEEzHyYvPQJECQKmDRFCDFFXeWKLzWLnaTvlqi5FBBMO8mUSiyGg
JQ0Shog6uTJhE2dKEgIkQBkQAxAAhAFZr51811rpzO7vnXpUVzerLV5rFFyKKuu1lqH0yaYN
EdCgahIDVxkoNNmUA+mDRSGgOrjJQP5MxAkaQNAlEYsMicMwWjA2MDRgMYGji4uLi4vo8Nnw
8Po+i1uzxFkNAkR5kcRKHZkoCUNAqZBMsEjCGgKFhEoKbMICr3baKzxu3IouWbeNuyiiuFFW
8Wd8uYrestXOWyq6lVkqpIAvPPfr5860nMzMzoPiBIC0slGlDywjF2WLVi1c8ZZaosXpXO92
yihctRcrzsTVa/aXomqXVSXs4PLVzx60ROLCLuSYVmdSXmNKyVEzKkuIFbV/nz5gTkknDrT8
pVXltNb1OW1sTVVlbE+0Vw3rS6qS9GlVtC6+0sjy2mNbSFSWab77nacJJIKlWNKsfFSNb1q6
2kUsVJKhAIUF72mZmQoQCECPo+j6Po+j6OGzRs2bLWLBsQCFBe95mZqgUIEIEIBCAQoKqpmZ
kKEAhB8uKrXtbGOc5rWZJJJLbbbbbbbbbbbbbbbbbbbbbbbbbbbbbeqXrrCb35b3ve973ve9
73ve97AN3d3d3MzjjMxu7u7ut0AAAAAed53nc/Ly46c82czeOnp7evM9fTmFSS2752944XJJ
mZnjdNHE0ptxOuvkV0sVJb9ldKIry2uxXna9Flb61tIVJcnsvq81bUzM1Qle7NXsTKsoWHGm
4LCBHp6enp6enfRo+HZ4WsVYtvtkmKGXV+Mwq4y1LFSW8Jnc4XmySTvKySq1ql3sSFSnX5ja
xV4rryxoVHX51UuNnWqpYqSzXe33t5vZJAXKrGtXbc8dXVdaukrVeKCflD85dUuzy+3Fsfg2
sVeLKLO97m97JJEUq71vTx9WdPNGrtruNWqSVKklSrxTtySYqCwgEIEcOHDhw4dmjRs2bKtY
NiCSvDx48bu7tdSv1UrJUlSV3d+95mZkLCAQgWa4Lz33w8Nnho6Oz4dnw2fKyy8XhJJJJJJJ
IkiSSSSSSSSSSSSdEiSSSSRIkkkkkkklJJJJJJJIkkkSSSJ0SSSSSSSSSSSSSSSSdEkkkkkk
kkiSSSSROhJJJJJLy9fPjnn37Xl27efbt79u3Y5znOc45iCICKF8q0WESKOKaZXHd3kV2WFA
7T35zOc6czMzKRhFlGpLYoSSyos2FqvFyvDrV2tqrFlOvLjVUrVJGS953ve05bc6lmL0rUTk
bzaYaiWwoQPMnDhw4cOHDo6Phw8JmyfBDV+2eMvIUIrFTDRapKPfi+4uuRvZ22nbXFrNafSe
OnUpK1xpS34+tZnjXLjm0h01ylapKPecznecpwkkiR24sK6sm349aK8lK1S8FjW9rs83VcXY
/B8i7ca8iFSV5vc53d64XJIr7cejKXbOnOy7LyFatlSVJWTtZt1IJAIQI4cOHDhw7OjR0dHZ
ag2Kk5ddZmZW8VKUUVJy3czMuOnHPjjjnxz4455rNZnXN+duSS22222222ySSFkkktttttkk
kkltkkkklxL11jr7gAAAAAG7u88887u7379+/dmZ379+5u7u7u6AAC8c8+nNEEQEeoiIgI+B
YVlEeyPiHp8EHtDMLnpdMeOrLGLw51tnO7lkrbMoqSsZ+axfPWpqxoLUOBfMTCkYLBrNnUNJ
EfF5arxTr8znsWmqbx+XSqpr8Vqkr3nDfd4Xdt4vexMvCKMzMIRqXDUUIEenps9PT06OjR4e
HharWY7M87HWGO1pLS6I8Y6L2275nxy81t8vdzjVnSqdsq1UKfLrcT5mPL5dxXhw53l5rbR3
nHzei2pJmlr5AyqrcXVDl1dduLHnDee83nW313u8W5mOqlF+sSEVfLbmj09PT09PT07NmzZ6
WdU22Ntu2xXTXnmdxBEBCQERARlCsWz7TRTPQ3u/P3N3rbbXDtd13cp1yYduRPbalU+aw7vO
b6vjKbba1qxUzdpYtaevh6enZ6enp2aPhw4dlvV3fFqwrurK7Vc9zrOBNtiec1bVO7s27vmV
KrtB3oXWvedObtONuuuI5ckNla/le7LfqqcfX67L2b33d3XBtsqtyXbq6viqlt5PT09PT09O
zZ0dHR2Wqqbfsz08PDw4zXPOnXXXXbv3722ySSSS222SSSSW2ySSSS22222222222221L066
xO/fv38eAAAAAAHPPPIAABu7u7u7u7u6AB58+by3lx5NSV8BPj5N77u+8hbburt2Y073bJxP
de4sA957VXe8sN90vG2hTJu1Lt1bnnyvlfK9PT06Mnw2dGzN63fGPFOZZV+cta2Lzq95qzbo
fWzbvcu1fJHTqc4I6XutZnO5u5vW2+VdOs73rLO18zwJyet2vc5qu+d97zm++tvpZ5U4xnV7
VrWW3Y9PT08PT02bOjo6Nmb2tZtptN3o7McHvXxGtGtJL5VfPnOuc753znOc5vVf1rKb8+7p
ofE+C/ie95zvW267zCab2u5lq3K6a1M7uTO97tddU67s5WXe5wHq+F8L4X1XDhw0cOjhwt4c
wvGctqSXV5vjOsCbbTu+a7sy67xhXB9rdx2YTed3acbcVkDsdd1W7q9dcjx9q8J8pebp33K9
jb1dpSl7SaC4g8QYwwLW6kCtMemQZQBJEySABjNk3IAHRn09Mnp6emzw7Ozs8LeBAFWsm5AO
CABCABCgAQiAmaaTkAoQAIQB5Ocu+KzfPPda1rWta1rWta1bbbbbZJJJJZJJJJbbbbbbbbbb
169evp7+3X39PX26+/jx48ePGZmZmbu7u7oAAA5555AA3d3d3d3d3W7u7u7u7u+c888vXnoJ
HvbI9QcMsPUXRdBZHSLIaCyIKFEB0Z1qcY+fLVZJ5GiC2mYQxA6ZZGENGLsuiLoSIJEEFkOm
RlGkUXtJSE2CRhHxEJERcQQYzm+PnzNWu275KRFIsi+qkKLsM4YEouhoJQkQWEAZyenp6een
p2bNnh0cPKv5SaLyyMIwgwesLIiwiUQss9Q0QXFEBgzWNe4za+EsmRFkBfTBiKRlsi6NUyUF
ISPiSxC77zZa3u26yi1ml9v3mb11pzO7xKjerklqTHbfS1m6BbGYc73O9bdw5m+XpDGkpqiM
uzbkM3PT09PT09OHZ2dnZs7uht27dNNNRrrrpppqfASKsWZ5c67aEVc68l81+Ff40+Wnztok
Vef9eilFzfLNfwXnv2cGoKX5aUoualF6iRVrzenzEhOGAE30ouj10lRYClwQlyUouRs06V1L
lVRdeApa8gKXI365v9OXRClzIS28qqqOnfzIS5P0pRcV2iRVqqi3Uot/qClrFRcrO3P8iRVt
fRd71Lv7mYd/f36aaajXXXTTTU8PF4vF8Xi/k8XP0ug7OzZNuwdrJSBMy25CkFVTbkCZlt81
+q6PaSSSWySXmrtdP23T19fXjjj3giIiIC4FVTbkP13CLn7X6yLl/nXz5b6/V+rP3+/v3+jx
9G7u7u5mZmY3d3d0ADjjgAAAAAAAD/F08enPpdKoghKOwvNm3IEzLbkOzs7O47Ozs2bNm19D
6JANuJKSNuJdtpXdtuJL/5eANsDs7OzQdncdmzs2bNlbCqptyBMy25Doj/whfbxlGzZs6Nmz
Zs6PsfY67Oz09OHDgkkkkkkkkkkkkkkkkkkkkklJJJJJJJJJJJJJJJJ0RJJJJJJJJJJJJJJJ
SSSSSSSSSRJJJJJJJJJJJJJJJJJJJJJJKSSSSSTpx8u3Xy7due3bt17dg0Ly9/W1vgWvzjbo
Ciqpt0GdmzZ1sN7jZs2bK2FVTbsAQUCgggiAQVVNuQsj+8EWtZtyH+JCCqptyB4eHh4eHh4d
h4bNmythVU25D8kFVTbkNkfmQiPzI6vr8vv3Ou9431+n6/PPn8/mzMzMxmZmYzMzMxu7u7oc
ccAAAAG7u7u7u7u7pu71unTp06dIBvnQTPGpAcy25I2X2bNmzZ0bNxs3B9EgG3ElJG3E6VaK
4hKO23ElJG3JGzZs2bPmzo2bNmwrYVVNuQPzqqbdH2Uotv0XHf2dP3PvJFfmvesXtW3ob+g5
ym5AbltyR+D8H4M/g/B+Do/Bs2brYVVNuQJmW3IUgqqbchwhByCIiIgGWtZt2iPDw8PDw8PD
s8NmzYq2R3arNUA5ltyf9Xn19i+q/Ve5a/vx4dcqurIHPkqWnv14+l49fH1/sdevx8fHxvwA
bu7u7uZmZjMzMzG7vHHG7ugAAAA3d3d3d3d3eegmfG3IEzLbkP3hHZ2dnZ2dnZs7Ozs7K7Ow
tazbkCZltyF7sLWs25AmZbckdnZ2dnZ2dnRvZs2VsKqm3IF4giAiqpvTYb6UXa5/cvt12e1K
K6V711LuXEtGfuuBci7ltW9eC+K8NV7OlZvLVbVs3rFu+quVYWqqqP/EiutbFvXwWlaZ2l0d
L+Kzs0XxWwkV0rXnXQvYuHIuG0kV9xIKcF/8XckU4UJCnbE7JA==
--------------010305000703040709010004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010305000703040709010004--
