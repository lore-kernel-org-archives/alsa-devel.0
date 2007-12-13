From: John Faith <jfaith@freescale.com>
Subject: Re: Alsa library for the arm-linux architecture
Date: Thu, 13 Dec 2007 12:12:39 -0800
Message-ID: <47619237.6000901@freescale.com>
References: <951b8d920712130537s2f6eacb1g53121e7e1c738b0d@mail.gmail.com>
	<476172D3.6000602@freescale.com>
	<F186B5A9-AD39-4670-9152-254BC1B7EFB6@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 613AA246C0
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 21:14:08 +0100 (CET)
In-Reply-To: <F186B5A9-AD39-4670-9152-254BC1B7EFB6@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Felipe Uderman <felipe.uderman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Hi,
> 
> On Dec 13, 2007, at 6:58 PM, John Faith wrote:
> 
>> Felipe Uderman wrote:
> 
>> We cross compile alsa-lib 1.0.11rc2 for ARM with:
>>
>> ./configure --prefix=/usr --host=arm-linux --build=i686-pc-linux-gnu
> 
> You should have a look at BR2 (http://buildroot.uclibc.org/) which 
> cross-compiles 1.0.14a for you, most probably also newer versions with 
> minor modifications to the appropriate .mk file.
> 
> Daniel
> 

Thanks for the suggestion.  We use a different cross build environment 
called LTIB (http://bitshrine.org).  The patches and build steps are in 
a .spec file like rpm and all enabled packages are built as part of the 
file system.  Building alsa can be done separately with: 'ltib -p alsa-lib'.

,
John
