From: Zephiris <zephiris@gmail.com>
Subject: Re: ATI IXP hardware mixing
Date: Thu, 14 Sep 2006 08:16:11 -0700
Message-ID: <eebrns$i2v$1@sea.gmane.org>
References: <eeboe2$4r0$1@sea.gmane.org> <1158245895.7948.69.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

> On Thu, 2006-09-14 at 07:19 -0700, Zephiris wrote:
>> Since people in ALSA devel channel won't answer, I'll have to ask on
>> mailing-list/newsgroup. I'm trying to get the ATI IXP driver to use
>> hardware mixing. The hardware supports it, FreeBSD and Windows support
>> it, and all I want is to know is what to change in the source that needs
>> to support it, since several glances through the source and brief API
>> docs, as well as mailing lists, etc, don't reveal effectively nothing
>> supporting hardware mixing at all.
> 
> How do you know the device is capable of hardware mixing?
> 
> Lee
> 
> 
Other operating systems support hardware mixing on it. FreeBSD reportedly
does, Windows definitely does (yay for hardware acceleration of DS/DS3D,
too; up to 26 streams) and I didn't ask 'if' it does, I asked how to try to
work with hardware mixing in ALSA. Documentation, general walk-through of
the steps required in difference to non-hardware mixed, anything, please?

I've been getting short-changed on answers so far (and was previously
stonewalled on AU8830 support, back when people in ALSA channels cheerily
claimed you couldn't get hardware mixing on that, either), and it's getting
frustrating. I'm not asking for a lecture on "you can't do that because
it's not status quo", but merely how to implement such changes in the
source code.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
