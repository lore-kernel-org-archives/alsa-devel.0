From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: alsa-utils-0.9.0beta12: Bug in configure
Date: Thu, 4 Apr 2002 08:37:13 -0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204040537.g345bvX19348@Port.imtp.ilyichevsk.odessa.ua>
References: <200204030808.g3388UX16054@Port.imtp.ilyichevsk.odessa.ua> <20020403215052J.siemer@panorama.hadiko.de>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 8bit
Received: from Port.imtp.ilyichevsk.odessa.ua (167.imtp.Ilyichevsk.Odessa.UA [195.66.192.167] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA08838
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 07:45:55 +0200
In-Reply-To: <20020403215052J.siemer@panorama.hadiko.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Siemer <siemer@panorama.hadiko.de>, Robert Siemer <Robert.Siemer@gmx.de>
Cc: alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

On 3 April 2002 17:50, Robert Siemer wrote:
> Re!
>
> From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
>
> > configure uses this to test whether there are alsa libs.
> > But this will fail always since nested functions are not
> > supported by C:
> >
> > int main() {
> >   void main(void) {  // !?
> >     ...
> >   }
> > }
>
> Just to make it clear: nested functions are supported by GNU C.
> But I don't know if it was intended here... (-:

That was the most obvious bogosity. There were others and conftest.c
did not compile. It should. And it did after I fixed configure not
to generate bogus C code.

In other words, alsa-utils configure.in needs to be fixed.
--
vda
