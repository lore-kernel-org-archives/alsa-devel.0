From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: use pnp instead of acpi for mpu401
Date: Fri, 04 Feb 2005 23:17:09 +0100
Message-ID: <4203F465.70607@free.fr>
References: <4203CDB1.7090200@free.fr> <s5hy8e4qfo0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hy8e4qfo0.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:
> At Fri, 04 Feb 2005 20:32:01 +0100,
> matthieu castet wrote:
> 
>>Hi,
>>
>>now that pnp support acpi via pnpacpi, couldn't be better to use pnp for 
>>mpu401 instead of acpi ?
>>
>>You can find here [1] a page I send to this mailling list a long time 
>>ago. It will need some cleanning.
>>
>>Any comments ?
> 
> 
> I prefer to merge your patch into mpu401.c rather than having two
> modules.  Given that PnP can replace it, the whole ifdef USE_ACPI_PNP
> parts can be stripped.
> 
No problem, I did that because it was too complicated to mix with acpi 
when I did it.
Do you want I make a patch ?

Regards,
Matthieu CASTET


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
