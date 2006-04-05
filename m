From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Wed, 5 Apr 2006 14:44:13 -0400
Message-ID: <d120d5000604051144r535e1b5k763269f1f5ef17ea__22567.7847084173$1144264443$gmane$org@mail.gmail.com>
References: <44238489.8090402@keyaccess.nl> <4432EF58.1060502@keyaccess.nl>
	 <44330DFA.4080106@keyaccess.nl>
	 <200604042145.24685.dtor_core@ameritech.net>
	 <44340E12.9000202@keyaccess.nl>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.237])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5885F147
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 20:44:15 +0200 (MEST)
Received: by wproxy.gmail.com with SMTP id i14so214387wra
        for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2006 11:44:13 -0700 (PDT)
In-Reply-To: <44340E12.9000202@keyaccess.nl>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

On 4/5/06, Rene Herman <rene.herman@keyaccess.nl> wrote:
> Dmitry Torokhov wrote:
>
> >> Well, we could in fact hang an unregister off device->private_data as
> >> per attached example. Wouldn't be _excessively_ ugly. Still sucks
> >> though.
> >
> > Plus it broke all the drivers that create platform devices before
> > registering drivers or the ones simply not using private data.
>
> No, this was just a suggestion for an ALSA specific workaround. I was
> suggesting ALSA drivers could do this.
>

Yes, I am sorry - I misread the code snipped as if it was in driver
core, not in ALSA itself.

--
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
