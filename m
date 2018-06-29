From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] vgaswitchroo: set audio client id
 according to bound gpu client id
Date: Fri, 29 Jun 2018 13:11:08 +0200
Message-ID: <20180629111108.GA11609@wunner.de>
References: <1530166933-21655-1-git-send-email-Jim.Qu@amd.com>
 <CADnq5_NcNfMD9UDN17c-513rD--kQY7nzw6OTgimV0pVqLjbOg@mail.gmail.com>
 <DM3PR12MB08737CF35AF6D0CE1A1BDC64994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629080634.GA7357@wunner.de>
 <DM3PR12MB08737DC9FB94BB6F3AEF5634994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
 <20180629092138.GA11849@wunner.de>
 <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62]) by alsa0.perex.cz (Postfix) with ESMTP id 69FE7267A34
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 13:11:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <DM3PR12MB08732DAAAA57739DCE431D66994E0@DM3PR12MB0873.namprd12.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Qu, Jim" <Jim.Qu@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 29, 2018 at 10:40:50AM +0000, Qu, Jim wrote:
> > That is no longer the case since v4.17.  The HDA controller now runtime
> > suspends autonomously, see commit 07f4f97d7b4b ("vga_switcheroo: Use
> > device link for HDA controller").
> > 
> > Your patch appears to be geared towards an older kernel version.
> > Please retest on the laptop in question with a v4.17+ kernel.
> 
> indeed? I used 4.13 on the platform. let me have a try with the patch
> you mentioned

The commit can't be cherry-picked by itself onto v4.13, it was part of
a larger series.  It's best to use a stock v4.17 kernel.

Note, a fix went into Linus' tree yesterday, commit 57cb54e53bdd
("ALSA: hda - Force to link down at runtime suspend on ATI/AMD HDMI").
Not sure if it's needed on your machine.

Thanks,

Lukas
