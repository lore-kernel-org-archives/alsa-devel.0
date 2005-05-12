From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/hda patch_realtek.c,1.7,1.8
Date: Thu, 12 May 2005 16:50:12 +0200
Message-ID: <m21x8ch523.fsf@vador.mandrakesoft.com>
References: <E1DWDnF-00080F-Ay@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1DWDnF-00080F-Ay@sc8-pr-cvs1.sourceforge.net> (Takashi Iwai's
	message of "Thu, 12 May 2005 06:32:01 -0700")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@users.sourceforge.net> writes:

> @@ -993,6 +1084,9 @@
>  	{ .modelname = "w810", .config = ALC880_W810 },
>  	{ .pci_vendor = 0x161f, .pci_device = 0x203d, .config = ALC880_W810 },
>  
> +	{ .modelname = "z71v", .config = ALC880_Z71V },
> +	{ .pci_vendor = 0x1043, .pci_device = 0x1964, .config = ALC880_Z71V },
> +
>  	{}
>  };

why not rename pci_vendor as pci_subvendor and pci_device as
pci_subdevice in hda_local.h:hda_board_config ?

this would reflect the reality since these pci ids are not the main
pci ids but the pci subids.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
