From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: Reforming S3C I2S towards supporting I2Sv4
Date: Sun, 2 May 2010 13:38:46 +0900
Message-ID: <i2w9c9fda241005012138j844af741va32948bb0971b77@mail.gmail.com>
References: <1268207335-9947-1-git-send-email-jassi.brar@samsung.com>
	<20100310142314.GD6850@sirena.org.uk>
	<20100427025848.GB24020@trinity.fluff.org>
	<q2x1b68c6791004262125o69932e63qd9ddc885b2627dd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9F0E0245FC
	for <alsa-devel@alsa-project.org>;
	Sun,  2 May 2010 06:38:49 +0200 (CEST)
Received: by vws16 with SMTP id 16so725673vws.38
	for <alsa-devel@alsa-project.org>; Sat, 01 May 2010 21:38:46 -0700 (PDT)
In-Reply-To: <q2x1b68c6791004262125o69932e63qd9ddc885b2627dd0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jassi Brar <jassi.brar@samsung.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Hi Jassi,

Do you have a plan to move or create the sound/soc/samsung or others
for future Samsung SoCs?
And can you make a document which SoCs use I2S version?
e.g.,
s3c24xx use I2Sv3
s3c64xx use I2Sv3 or 4??
s5p64xx use I2Sv4
s5pc1xx use I2Sv5
and so on

How about to give name samsung-i2cvx for common use instead of cpu name?

Thank you,
Kyungmin Park

On Tue, Apr 27, 2010 at 1:25 PM, jassi brar <jassisinghbrar@gmail.com> wrot=
e:
> On Tue, Apr 27, 2010 at 11:58 AM, Ben Dooks <ben-linux@fluff.org> wrote:
>> On Wed, Mar 10, 2010 at 02:23:15PM +0000, Mark Brown wrote:
>>> On Wed, Mar 10, 2010 at 04:48:55PM +0900, Jassi Brar wrote:
>>>
>>> > =A0I have prepared some patches that debug and modify the behaviour of
>>> > extant S3C I2S support towards managing I2Sv4 controllers as well.
>>>
>>> OK, I think that's everything. =A0I've not applied anything after the
>>> header move yet due to the need for an ack from Ben. =A0Any patches I
>>> didn't specifically comment on are OK. =A0Overall it's all good, most of
>>> the issues are minor.
>>
>> I'd like to see a bit of header reformatting to make them readable
>> if they're not already merged.
> Ok.
>
>> the header moves are ok by me, much prefer to see them git mv'd than
>> copy and rm'd.
> Ok, I will move the header.
> Though the original plan was to create a copy in sound/soc/s3c24xx and
> render useless the one in plat-samsung/include/plat/ which could
> be independently removed from your tree. That was meant to avoid
> cross tree changes.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
