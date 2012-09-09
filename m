From: Sergiu Giurgiu <sgiurgiu11@gmail.com>
Subject: Re: [PATCH - ALSA: snd-virtuoso 1/1] Xonar DSX support
Date: Sun, 09 Sep 2012 04:01:21 -0400
Message-ID: <504C4CD1.3070303@gmail.com>
References: <504b9831.aac4320a.1f39.ffff8a9f@mx.google.com>
 <504C6973.6050308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <504C6973.6050308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/09/2012 06:03 AM, Clemens Ladisch wrote:
> sgiurgiu11@gmail.com wrote:
>> From: Sergiu Giurgiu <sgiurgiu11@gmail.com>
>>
>> Signed-off-by: Sergiu Giurgiu <sgiurgiu11@gmail.com>
> Many thanks for writing this patch!
> However, please mention which features work, don't work, or aren't tested.
I didn't see where (how) could i specify the mail body when using git =

send-email, I'll look/study further so that in the future I=92ll have more =

context around the pieces of code written. Maybe the git commit comment??

What works/has been tested:
- play sound
- volume controls (mute also)

Since I only have 2 speakers, I cannot say anything about its 5.1 support.
What "should" work: everything that works for Xonar DS. As far as I can =

tell, DS and DSX are the same card the only difference being PCI vs =

PCIE. The fact that it was only required such a minor change to make it =

play sounds, makes it very likely. It has been running for the last 2 =

days on my PC.

>
>> +++ b/mirror/sound/pci/oxygen/xonar_wm87x6.c
>>
>> +static const struct oxygen_model model_xonar_dsx =3D {
>> +	.shortname =3D "Xonar DSX",
>> +     ...
> This structure is almost the same as model_xonar_ds; please merge
> them.  (See xonar_cs43xx.c for an example.)
The 2 structures are the same since we are talking about the same chip. =

I'll take a look in the file you've mentioned to see if there's a better =

way. I've started with the second struct since i had no idea what =

changes would be required, but yes, other than the name nothing is =

different.
>
> Regards,
> Clemens
All the best,
Sergiu.
