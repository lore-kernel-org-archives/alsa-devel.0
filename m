From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 11:42:24 +0200
Message-ID: <4E537600.2090006@amlie.name>
References: <4E5234F0.8000502@amlie.name>	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>	<4E52401C.8030605@amlie.name>	<CACTFLANnEEV8waJvs7Yw4Y_KdD5CmK565+YBWLqZ8tu8qfGO3w@mail.gmail.com>	<4E53585D.9050004@amlie.name>	<CACTFLAP0gMjSShp59Gn1q+aXzPMNGMH05ze_p5S0sEsYwum9JA@mail.gmail.com>	<1314090212.3688.6.camel@mattotaupa>
	<CACTFLAORzpmfp6=0ywokDP4j8E=zK6nZ1RsHS=JJ3FNL67qJPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy7-pub.bluehost.com (oproxy7-pub.bluehost.com
	[67.222.55.9]) by alsa0.perex.cz (Postfix) with SMTP id 75E8E1039D9
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 11:42:38 +0200 (CEST)
In-Reply-To: <CACTFLAORzpmfp6=0ywokDP4j8E=zK6nZ1RsHS=JJ3FNL67qJPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/23/11 11:22, Daniel Mack wrote:
> On Tue, Aug 23, 2011 at 11:03 AM, Paul Menzel
> <paulepanter@users.sourceforge.net> wrote:
>> Am Dienstag, den 23.08.2011, 10:43 +0200 schrieb Daniel Mack:
>>> On Tue, Aug 23, 2011 at 9:35 AM, Kristian Amlie <kristian@amlie.name> w=
rote:
>>>> The Windows drivers are called "USB Serial Converter" and "USB Serial
>>>> Port", so maybe it's all wrapped in a different protocol. Does that na=
me
>>>> ring a bell?
>>>
>>> That's possible, and it should be easy to support these type of
>>> devices in ALSA. However, some logic is neccessary to configure the
>>> hardware to its correct baud rate and hardware protocol. The easiest
>>> way to determine the setup sequence is certainly to sniff the Windows
>>> driver communication with some tool like usbsnoop. Can you give that a
>>> try?

I will, but it will take a bit of time, since well, I have to install
Windows first... :-)

The driver names I just read from the manual.

>> =85 and ask the manufacturer about GNU/Linux support.
>>
>> Something like, you bought the hardware and expect it to work
>> everywhere. Additionally they make money by selling the hardware and not
>> developing a driver, so they should publish the documentation and even
>> pay someone =96 like Daniel or Clemens ? =96 to write the support for th=
eir
>> hardware. (Only when they say they do not have any money or something
>> like that, you can also tell them to donate/provide free hardware for
>> the developer and a contact address to their M$ Windows developer for
>> questions.)
> =

> While I agree in general to your points, I think its not worth the
> effort in this particular case. It's probably very easy to add support
> for this by just sending one magic usb_control_msg up-front, and it's
> not complicated to sniff that value. From a customer standpoint,
> again, I'm sure the manufacturer will just state that they didn't
> promise any Linux support, and so you can't claim it.

Their homepage states "We are currently in the final phase of
development in making all of our instruments class compliant.", which I
take to mean that they want their future products to use a standard MIDI
interface. Right now, Windows 7 and Vista 64 users are also left in the
dark, so I think they are as eager to fix this as we are, they just
decided to do it on the hardware side instead of the software side.

-- =

Kristian
