From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME HDSP 9652 vs DIGI 9652
Date: Fri, 25 Jul 2003 11:35:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307251135.12420.torger@ludd.luth.se>
References: <1059100074.3f2095aaafe13@webdjn.unm.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1059100074.3f2095aaafe13@webdjn.unm.edu>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Sheltraw <sheltraw@unm.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 25 July 2003 04.27, Daniel Sheltraw wrote:
> Hello ALSA list
>
> Are the registers of RME HDSP 9652 and DIGI 9652 identical. If
> not does anyone have datasheets for the HDSP 9652. I need them
> for a custom application and I just noticed that RME discontinued
> the DIGI 9652. If not, do you have an email address for the RME
> engineer that could provide the datasheets.

No, the registers are not the same. However, you can make the HDSP 9652 
behave almost exactly like an DIGI 9652. I think that the only way to 
find out the registers is to look at the source code of the ALSA 
driver, since I think RME is quite restrictive with who they share 
their internal data sheets.

/Anders



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
