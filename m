From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Control API, help
Date: Mon, 19 Jan 2004 08:31:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074515461.1048.21.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to familiarize myself with the Control API (userland
programs). I'm somewhat scared about the huge amount of API functions...

I hammered some code together but i'm not very sure if i'm doing it
right. If anyone can comment about this concept code, would be nice.

What i intend to do:

1) Gain access to a control with numeric ID "CTRL_HRTF".
2) Read some info (value limits and such).
3) Write 6 (upto 112) integer values into that control.

The commented code (//) are things that i believe are not needed.

void test() {
  int i;
  snd_kcontrol_t *ctlp;
	
  /* Open the control. Is this really needed ? */
  if ((err = snd_ctl_open(&ctlp, "3d_hrtf", SND_CTL_ASYNC)) != 0) {
    fprintf (stderr, "3D CTL failed: (%s)\n", snd_strerror (err));
    exit(1);
  }
  
  /* Retrieve some ifno to check if anything is as expected. */
  snd_ctl_elem_info_t *info;
  snd_ctl_card_info_alloca(info)
	
  /* Setup info struct. */
  //snd_ctl_elem_info_set_id(info, const snd_ctl_elem_id_t *ptr);
  snd_ctl_elem_info_set_numid(info, CTRL_HRTF);
  snd_ctl_elem_info_set_interface(info, snd_ctl_elem_iface_t val);
  snd_ctl_elem_info_set_device(info, 0);
  snd_ctl_elem_info_set_subdevice(info, 2);
  //snd_ctl_elem_info_set_name(info, const char *val);
	
  /* Get info field 0. */
  snd_ctl_elem_info_set_index(info, 0);
  if ((err = snd_ctl_elem_info(ctlp, info)) != 0) {
    fprintf (stderr, "3D CTL failed: (%s)\n", snd_strerror (err));
    exit(1);
  }
  snd_ctl_elem_info_free(info);
	
  /* Declare and setup ctl_elem_value struct. */
  snd_ctl_elem_value_t *ctl_val;
  snd_ctl_elem_value_alloca(ctl_val);
	
  //snd_ctl_elem_value_set_id(ctl_val, const snd_ctl_elem_id_t *ptr);
  snd_ctl_elem_value_set_numid(ctl_val, CTRL_HRTF /* Some const defined
elsewhere. */);
  snd_ctl_elem_value_set_interface(ctl_val, SNDRV_CTL_ELEM_IFACE_PCM);
  snd_ctl_elem_value_set_device(ctl_val, 0);
  snd_ctl_elem_value_set_subdevice(ctl_val, 2);
  //snd_ctl_elem_value_set_name(ctl_val, const char *val);

  /* Write values. */
  for (i=0; i<6; i++) {
    snd_ctl_elem_value_set_index(ctl_val, i);
    snd_ctl_elem_value_alloca(ctl_val);
    snd_ctl_elem_value_set_integer(ctl_val, unsigned int idx, long val);
  }
  /* Dispatch ctl write to soundcard. */
  if ((err = snd_ctl_elem_write(ctlp, &control)) != 0) {
    fprintf (stderr, "3D CTL failed: (%s)\n", snd_strerror (err));
    exit(1);
  }
  snd_ctl_elem_value_free(ctl_val);
}

Thank you very much.

-- 
Manuel Jander
mjander(at)users(dot)sourceforge(dot)net



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
