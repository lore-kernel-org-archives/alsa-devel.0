From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 13:37:59 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512161323540.10849@tm8103.perex-int.cz>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
 <43A1C7F5.6070307@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43A1C7F5.6070307@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Dec 2005, James Courtier-Dutton wrote:

> Efficient in what way?
> The current method is efficient in that it is implemented using very few lines
> of code, and thus not much code bloat.

That's a question. I'm trying to propose something simple which can be
handled in most easy way.

> Why do you want to place limits on the size of the request/response?

No, the limits will be similar as yours. If you have 2048 bytes for ioctl 
request, there is plenty space for the response values.

My question is what is better: The static structure or dynamically created
containers.

With my proposal, the lowlevel driver can handle only such callbacks:

struct snd_ctl_extra {
	unsigned char key[8][8];
	unsigned char value[2048-256];
};

static int usb_control_get_extra_info(struct snd_kcontrol *kcontrol, 
				      struct snd_ctl_extra *extra)
{
	if (!strcmp(extra->key[0], "dB Scale")) {
		*((unsigned int *)extra) = 0x11223344;
		return 0;
	}
	return -ENOENT;
}

As you see:

1) no value size encoding / decoding (size is already known, because it is 
   assigned to key)
2) the callback can be shared among many controls (ususally one lowlevel
   driver has many controls with same dB scale values)
3) extra code for specific controls might be handled in the extra callback
   as 'if (kcontrol == driver->my_specific_kcontrol) { do_it; return 0; }'

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
