From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [bug report] ALSA: usb: initial USB Audio Device
 Class 3.0 support
Date: Fri, 12 Oct 2018 16:51:23 +0300
Message-ID: <20181012135123.plusqifezr7ck3c6@mwanda>
References: <20181012134823.GA1711@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 658C0267845
 for <alsa-devel@alsa-project.org>; Fri, 12 Oct 2018 15:51:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181012134823.GA1711@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ruslan.bilovol@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 12, 2018 at 04:48:23PM +0300, Dan Carpenter wrote:
>    966          /*
>    967           * Second step: allocate needed amount of memory
>    968           * and request Cluster Descriptor
>    969           */
>    970          wLength = le16_to_cpu(hc_header.wLength);
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> My private build of Smatch complains that all le16_to_cpu() data
> probably comes from untrusted sources.
> 
>    971          cluster = kzalloc(wLength, GFP_KERNEL);
>                 ^^^^^^^
> Maybe we're not allocating enough bytes for the cluster struct (8 bytes).
> 
>    972          if (!cluster)
>    973                  return ERR_PTR(-ENOMEM);
>    974          err = snd_usb_ctl_msg(chip->dev,
>    975                          usb_rcvctrlpipe(chip->dev, 0),
>    976                          UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
>    977                          USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
>    978                          cluster_id,
>    979                          snd_usb_ctrl_intf(chip),
>    980                          cluster, wLength);
                                  ^^^^^^^

Also I just wanted to note as well that cluser->wLength is set by the
USB device here and we don't have a good reason to assume it's valid.

>    981          if (err < 0) {
>    982                  kfree(cluster);
>    983                  return ERR_PTR(err);
>    984          } else if (err != wLength) {
>    985                  dev_err(&dev->dev,
>    986                          "%u:%d : can't get Cluster Descriptor\n",
>    987                          iface_no, altno);
>    988                  kfree(cluster);
>    989                  return ERR_PTR(-EIO);
>    990          }
>    991  
>    992          num_channels = cluster->bNrChannels;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    993          chmap = convert_chmap_v3(cluster);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

But we trust it in convert_chmap_v3() so that's a second potential out
of bounds.

regards,
dan carpenter
