From: jayakumar alsa <jayakumar.alsa@gmail.com>
Subject: Re: cs5536 ID for cs5535audio
Date: Wed, 14 Dec 2005 22:46:58 -0800
Message-ID: <47f5dce30512142246g53896be6t4aedfe7a133a04af@mail.gmail.com>
References: <200512141431.32685.rene@exactcode.de>
	 <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <47f5dce30512142226n18fc4280m26ce5b0bb4b80d3f@mail.gmail.com>
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
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

On 12/14/05, jayakumar alsa <jayakumar.alsa@gmail.com> wrote:
> On 12/14/05, Ren=E9 Rebe <rene@exactcode.de> wrote:
> >  static struct pci_device_id snd_cs5535audio_ids[] =3D {
> > -=09{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
> > -=09=09PCI_ANY_ID, 0, 0, 0, },
> > +=09{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
> > +=09  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> > +=09{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
> > +=09  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
> >  =09{}
> >  };

Ren=E9,

Also, as Jiri suggested, could you change those to:

PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO)
PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO)

Thanks,
jk


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
