From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always
	muted on boot
Date: Thu, 22 Jun 2006 06:30:47 +0200
Message-ID: <10ed9f9fe31a2c8581db8f3fc66a7a3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F0CB61A9
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jun 2006 06:30:47 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321> 
======================================================================
Reported By:                64bitten
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   321
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               gentoo
Kernel Version:             2.6.6
======================================================================
Date Submitted:             06-02-2004 08:09 CEST
Last Modified:              06-22-2006 06:30 CEST
======================================================================
Summary:                    Left front channel always muted on boot
Description: 
ice1724 (M Audio Revolution 7.1 in my case) always restores the mixer
settings at boot, but the left front channel is muted regardless.  The fix
is to run alsamixer and adjust the slider again.  This forces the channel
to unmute.  Should I be worried "amixer scontrols" reports everything as
"Mono" as well?
======================================================================

----------------------------------------------------------------------
 Raymond - 06-21-06 14:25 
----------------------------------------------------------------------
alsamixer expect index controls are continuous, but the driver implemented
in non-standard way (i.e. Deemphasis appear between DAC volume controls).
You will need special tool (e.g envy24control) to handle this special
implementation
 

static inline unsigned int snd_ctl_get_ioffnum(struct snd_kcontrol *kctl,
struct snd_ctl_elem_id *id)
{
	return id->numid - kctl->id.numid;
}

static inline unsigned int snd_ctl_get_ioffidx(struct snd_kcontrol *kctl,
struct snd_ctl_elem_id *id)
{
	return id->index - kctl->id.index;
}

static inline unsigned int snd_ctl_get_ioff(struct snd_kcontrol *kctl,
struct snd_ctl_elem_id *id)
{
	if (id->numid) {
		return snd_ctl_get_ioffnum(kctl, id);
	} else {
		return snd_ctl_get_ioffidx(kctl, id);
	}
}

static inline struct snd_ctl_elem_id *snd_ctl_build_ioff(struct
snd_ctl_elem_id *dst_id,
						    struct snd_kcontrol *src_kctl,
						    unsigned int offset)
{
	*dst_id = src_kctl->id;
	dst_id->index += offset;
	dst_id->numid += offset;
	return dst_id;
}

control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		value 15
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 1
		value 15
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '44.1kHz'
		comment.item.1 Off
		comment.item.2 '48kHz'
		comment.item.3 '32kHz'
		iface MIXER
		name Deemphasis
		value Off
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 2
		value 0
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 3
		value 0
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 4
		value 0
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 5
		value 0
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 6
		value 0
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 255'
		iface MIXER
		name 'DAC Volume'
		index 7
		value 0
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '44.1kHz'
		comment.item.1 Off
		comment.item.2 '48kHz'
		comment.item.3 '32kHz'
		iface MIXER
		name Deemphasis
		index 1
		value Off
	}



----------------------------------------------------------------------
 Raymond - 06-22-06 06:30 
----------------------------------------------------------------------
I don't have this card, alsactl most likely cannot restore the correct
values for those controls build by snd_akm4xxx_build_controls()

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 08:09 64bitten       New Issue                                    
06-02-04 08:09 64bitten       Distribution              => gentoo          
06-02-04 08:09 64bitten       Kernel Version            => 2.6.6           
12-17-04 03:15 K6-III         Note Added: 0002845                          
12-17-04 06:46 herby          Note Added: 0002846                          
12-17-04 06:51 rlrevell       Note Added: 0002847                          
12-21-04 07:09 64bitten       File Added: amixer.bad                       
12-21-04 07:10 64bitten       Note Added: 0002896                          
04-09-05 17:24 jdthood        Status                   new => acknowledged 
10-20-05 02:36 sst4           Note Added: 0006497                          
10-20-05 05:18 Fran           Note Added: 0006498                          
10-21-05 03:51 64bitten       Note Added: 0006509                          
11-18-05 21:03 goldenfish     Note Added: 0006758                          
11-18-05 21:04 goldenfish     File Added: proc_changes.diff                    
06-20-06 22:55 effie          Issue Monitored: effie                       
06-20-06 23:05 effie          Issue End Monitor: effie                     
06-20-06 23:29 effie          Note Added: 0010356                          
06-20-06 23:31 effie          Note Edited: 0010356                         
06-21-06 06:10 Raymond        Note Added: 0010382                          
06-21-06 09:05 goldenfish     Note Added: 0010384                          
06-21-06 09:07 goldenfish     File Added: asound.state                     
06-21-06 09:37 herby          Note Added: 0010388                          
06-21-06 10:00 Raymond        Note Added: 0010389                          
06-21-06 10:01 Raymond        Note Edited: 0010389                         
06-21-06 10:17 Raymond        Note Edited: 0010389                         
06-21-06 10:36 Raymond        Note Edited: 0010389                         
06-21-06 14:25 Raymond        Note Edited: 0010389                         
06-22-06 06:30 Raymond        Note Added: 0010417                          
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
