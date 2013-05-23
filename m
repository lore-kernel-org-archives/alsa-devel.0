From: "David Laight" <David.Laight@ACULAB.COM>
Subject: RE: [PATCH] ASoC: fsl: expand the size of the name in fsl_ssi_private
 struct
Date: Thu, 23 May 2013 11:21:19 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7248@saturn3.aculab.com>
References: <1369299072-25147-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-class: urn:content-classes:message
In-Reply-To: <1369299072-25147-1-git-send-email-b42378@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

> strcpy(ssi_private->name, p) in probe() sets "name" by "p", gotten from dts,
> while the length of "p", if the devicetree node name of SSI is commonly set,
> would always be larger than 1 char size, so need a larger size for "name".

Are you sure this isn't allowed for when the structure is allocated?
Otherwise you also need to use strlcpy() as well.

> @@ -152,5 +152,5 @@ struct fsl_ssi_private {
>  	} stats;
> 
> -	char name[1];
> +	char name[32];
>  };

This looks like what c99 allows 'char name[0]' be used for.
But ensure the \0 is allowed for before changing to 1 to 0.

	David
