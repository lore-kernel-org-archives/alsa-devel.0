From: Robert Siemer <Robert.Siemer@gmx.de>
Subject: Re: alsa-utils-0.9.0beta12: Bug in configure
Date: Wed, 03 Apr 2002 21:50:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020403215052J.siemer@panorama.hadiko.de>
References: <200204030808.g3388UX16054@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: Robert Siemer <siemer@panorama.hadiko.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from mailgate.rz.uni-karlsruhe.de (exim@mailgate.rz.uni-karlsruhe.de [129.13.64.97])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA31555
	for <alsa-devel@alsa-project.org>; Wed, 3 Apr 2002 21:51:02 +0200
Received: from panorama.hadiko.de (hadii309.hadiko.uni-karlsruhe.de [172.20.44.69])
	by nce2.hadiko.de (8.11.3/8.11.3) with SMTP id g33Jorx13886
	for <alsa-devel@alsa-project.org>; Wed, 3 Apr 2002 21:50:54 +0200 (MET DST)
In-Reply-To: <200204030808.g3388UX16054@Port.imtp.ilyichevsk.odessa.ua>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: alsa-devel@alsa-project.org, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Re!

From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>

> configure uses this to test whether there are alsa libs.
> But this will fail always since nested functions are not
> supported by C:
> 
> int main() {
>   void main(void) {  // !?
>     ...
>   }
> }

Just to make it clear: nested functions are supported by GNU C.
But I don't know if it was intended here... (-:


Bye,
	Rob
