From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC] Scenario / Use Case manager updates.
Date: Tue, 08 Jun 2010 16:25:27 +0100
Message-ID: <1276010727.3003.371.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 502C22445B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 17:25:36 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3063505fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2010 08:25:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Justin Xu <justinx@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Some updates have been recently made to the ALSA audio hardware
scenario / use case manager in order to provide more flexible support
for smart phones and other complex audio devices. The updates are mostly
based around the need to provide further simplicity for constructing and
de-constructing use case transitions.

It's intended these updates will be the last before upstream submission.

Use cases can now be divided into three components rather than a single
entity as before. This gives the advantage that we can now react better
to asynchronous events like a headphone insertion or playing a ringtone
for an incoming call when the user is listening to music. It also means
we will have less and smaller use case configuration files. 

The three components of a use case are now :-

1) Verb (or action). This is mandatory and describes (in terms of ALSA
control settings) the system use case action. e.g "Phone Call", "Music
Playback".

2) Device. This is also mandatory and describes the audio playback or
capture device. e.g. "Handset", "Bluetooth", "Headset".

3) Modifier. This is optional and is used to modify the current use case
verb. i.e. The user could be listening to music when an incoming phone
call requires that a ring tone is played. In this case the use case verb
would be set to "Music Playback" when the music playback started and
then the "Tone Playback" modifier could be enabled to play the ring
tone. The use case verb would then be changed to "Voice Call" if the
call was accepted. 

The updates have not yet made it into the alsa-lib scenario branch here
yet :- 

http://git.alsa-project.org/?p=alsa-lib.git;a=shortlog;h=ascenario

But they do exist in the use-case-verb branch here:-

http://git.slimlogic.co.uk/cgi-bin/cgit.cgi/alsa-lib.git/log/?h=use-case-verb

(History to be rebased for upstream shortly)

The main code changes from the scenario branch are :-

  o  Rename API, files and directories from scenario to use case.
  o  Support for changing use case verb (rather than use case verb +
device + modifier as a large less flexible compound use case as before)
  o  Support for enabling multiple use case devices.
  o  Support for enabling multiple use case modifiers.
  o  Added more code documentation to public API header and core.

Still todo before upstream:-

  o  Mutex around public API
  o  Implement notifiers.
  o  Support user defined transition sequences between use cases verbs,
devices and modifiers.

One thing that is still undecided before upstream submission is the
management of the use case configuration files for each device/machine
type. They could either exist in a directory of alsa-lib or
alternatively we could have a separate git repository (with more
frequent releases) containing use case configuration data ? Any other
options ?

Thanks

Liam

----

/**
 * \file include/use-case.h
 * \brief use case interface for the ALSA driver
 * \author Liam Girdwood <lrg@slimlogic.co.uk>
 * \author Stefan Schmidt <stefan@slimlogic.co.uk>
 * \author Jaroslav Kysela <perex@perex.cz>
 * \author Justin Xu <justin@slimlogic.co.uk>
 * \date 2008-2010
 */
/*
 *
 *   This library is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Lesser General Public License as
 *   published by the Free Software Foundation; either version 2.1 of
 *   the License, or (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Lesser General Public License for more details.
 *
 *   You should have received a copy of the GNU Lesser General Public
 *   License along with this library; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 *  Copyright (C) 2008-2010 SlimLogic Ltd
 *  Copyright (C) 2010 Wolfson Microelectronics PLC
 *  Copyright (C) 2010 Texas Instruments Inc.
 */

#ifndef __ALSA_USE_CASE_H
#define __ALSA_USE_CASE_H

#ifdef __cplusplus
extern "C" {
#endif

/**
 *  \defgroup Use Case Interface
 *  The ALSA Use Case manager interface.
 *  See \ref Usecase page for more details.
 *  \{
 */
     
/**
 * ALSA Use Case Interface
 *
 * The use case manager works by configuring the sound card ALSA kcontrols to
 * change the hardware digital and analog audio routing to match the requested
 * device use case. The use case manager kcontrol configurations are stored in
 * easy to modify text files. 
 * 
 * An audio use case can be defined by a verb and device parameter. The verb
 * describes the use case action i.e. a phone call, listening to music, recording
 * a conversation etc. The device describes the physical audio capture and playback
 * hardware i.e. headphones, phone handset, bluetooth headset, etc.
 *
 * It's intended clients will mostly only need to set the use case verb and
 * device for each system use case change (as the verb and device parameters
 * cover most audio use cases).
 *
 * However there are times when a use case has to be modified at runtime. e.g.
 * 
 *  o Incoming phone call when the device is playing music
 *  o Recording sections of a phone call
 *  o Playing tones during a call.
 *
 * In order to allow asynchronous runtime use case adaptations, we have a third
 * optional modifier parameter that can be used to further configure
 * the use case during live audio runtime.
 *
 * This interface allows clients to :-
 *
 *  o Query the supported use case verbs, devices and modifiers for the machine.
 *  o Set and Get use case verbs, devices and modifiers for the machine.
 *  o Get the ALSA PCM playback and capture device PCMs for use case verb and
 *     modifier.
 *  o Get the QoS parameter for each use case verb and modifier.
 *  o Get the ALSA master playback and capture volume/switch kcontrols 
 *     for each use case.
 *  o Be notified when the use case verb, device, modifier changes.
 */


/*
 * Use Case Verb.
 *
 * The use case verb is the main device audio action. e.g. the "HiFi" use
 * case verb will configure the audio hardware for HiFi Music playback
 * and capture.
 */
#define SND_USE_CASE_VERB_INACTIVE		"Inactive"
#define SND_USE_CASE_VERB_HIFI			"HiFi"
#define SND_USE_CASE_VERB_HIFI_LOW_POWER	"HiFi Low Power"
#define SND_USE_CASE_VERB_VOICE			"Voice"
#define SND_USE_CASE_VERB_VOICE_LOW_POWER	"Voice Low Power"
#define SND_USE_CASE_VERB_VOICECALL		"Voice Call"
#define SND_USE_CASE_VERB_IP_VOICECALL		"Voice Call IP"
#define SND_USE_CASE_VERB_ANALOG_RADIO		"FM Analog Radio"
#define SND_USE_CASE_VERB_DIGITAL_RADIO		"FM Digital Radio"
/* add new verbs to end of list */


/*
 * Use Case Device.
 *
 * Physical system devices the render and capture audio. Devices can be OR'ed
 * together to support audio on similtanious devices.
 */
#define SND_USE_CASE_DEV_NONE		"None"
#define SND_USE_CASE_DEV_SPEAKER	"Speaker"
#define SND_USE_CASE_DEV_LINE		"Line"
#define SND_USE_CASE_DEV_HEADPHONES	"Headphones"
#define SND_USE_CASE_DEV_HEADSET	"Headset"
#define SND_USE_CASE_DEV_HANDSET	"Handset"
#define SND_USE_CASE_DEV_BLUETOOTH	"Bluetooth"
#define SND_USE_CASE_DEV_EARPIECE	"Earpiece"
#define SND_USE_CASE_DEV_SPDIF		"SPDIF"
#define SND_USE_CASE_DEV_HDMI		"HDMI"
/* add new devices to end of list */


/* 
 * Use Case Modifiers.
 * 
 * The use case modifier allows runtime configuration changes to deal with
 * asynchronous events.
 * 
 * e.g. to record a voice call :-
 *  1. Set verb to SND_USE_CASE_VERB_VOICECALL (for voice call)
 *  2. Set modifier SND_USE_CASE_MOD_CAPTURE_VOICE when capture required.
 *  3. Call snd_use_case_get_verb_capture_pcm() to get ALSA source PCM
 *     with captured voice pcm data.
 * 
 * e.g. to play a ring tone when listenin to MP3 Music :-
 *  1. Set verb to SND_USE_CASE_VERB_HIFI (for MP3 playback)
 *  2. Set modifier to SND_USE_CASE_MOD_PLAY_TONE when incoming call happens.
 *  3. Call snd_use_case_get_verb_playback_pcm() to get ALSA PCM sink for
 *     ringtone pcm data.
 */
#define SND_USE_CASE_MOD_CAPTURE_VOICE		"Capture Voice"
#define SND_USE_CASE_MOD_CAPTURE_MUSIC		"Capture Music"
#define SND_USE_CASE_MOD_PLAY_MUSIC		"Play Music"
#define SND_USE_CASE_MOD_PLAY_VOICE		"Play Voice"
#define SND_USE_CASE_MOD_PLAY_TONE		"Play Tone"
/* add new modifiers to end of list */


/**
 * QoS - Quality of Service
 *
 * The interface allows clients to determine the audio QoS required for each
 * use case verb and modifier. It's intended as an optional hint to the
 * audio driver in order to lower power consumption.
 *
 */ 
enum snd_use_case_qos {
	SND_USE_CASE_QOS_MUSIC = 0,
	SND_USE_CASE_QOS_VOICE = 1,
	SND_USE_CASE_QOS_TONES = 2,
};

/*
 * Use Case Control Aliases.
 *
 * Use cases often use different internal hardware paths to route digital and
 * analog audio. This can mean different controls are used to change volumes
 * depending on the particular use case. This interface allows clients to
 * find out the hardware controls associated with each use case.
 */
enum snd_use_case_control_alias {
	SND_USE_CASE_ALIAS_PLAYBACK_VOLUME = 0,
	SND_USE_CASE_ALIAS_PLAYBACK_SWITCH,
	SND_USE_CASE_ALIAS_CAPTURE_VOLUME,
	SND_USE_CASE_ALIAS_CAPTURE_SWITCH,
};

/** use case container */
typedef struct snd_use_case_mgr snd_use_case_mgr_t;

/*
 * Use case change notifier.
 *
 * Clients can be notified when the use case verb, device or modifier changes.
 */
 
#define SND_USE_CASE_NOTIFY_VERB		0x1
#define SND_USE_CASE_NOTIFY_DEVICE		0x2
#define SND_USE_CASE_NOTIFY_MODIFIER		0x4

typedef int (*snd_use_case_notifier_t)(snd_use_case_mgr_t *,
	int notify_status, void *data);


/**
 * \brief List supported use case verbs for given soundcard
 * \param uc_mgr Use case manager
 * \param verb Returned list of supported use case verbs
 * \return Number of use case verbs if success, otherwise a negative error code
 */
int snd_use_case_get_verb_list(snd_use_case_mgr_t *uc_mgr, const char **verb[]);

/**
 * \brief List supported use case devices for given use case verb
 * \param uc_mgr Use case manager
 * \param verb Verb name.
 * \param device Returned list of supported use case devices
 * \return Number of use case devices if success, otherwise a negative error code
 */
int snd_use_case_get_device_list(snd_use_case_mgr_t *uc_mgr,
		const char *verb, const char **device[]);

/**
 * \brief List supported use case verb modifiers for given verb
 * \param uc_mgr use case manager
 * \param verb verb id.
 * \param mod returned list of supported use case modifier id and names
 * \return number of use case modifiers if success, otherwise a negative error code
 */
int snd_use_case_get_mod_list(snd_use_case_mgr_t *uc_mgr,
		const char *verb, const char **mod[]);

/**
 * \brief Set new use case verb for sound card
 * \param uc_mgr Use case manager
 * \param verb Verb
 * \return Zero if success, otherwise a negative error code
 */
int snd_use_case_set_verb(snd_use_case_mgr_t *uc_mgr, const char *verb);

/**
 * \brief Enable use case device for current use case verb
 * \param uc_mgr Use case manager
 * \param device Device
 * \return Zero if success, otherwise a negative error code
 */
int snd_use_case_enable_device(snd_use_case_mgr_t *uc_mgr, const char *device);

/**
 * \brief Disable use case device for current use case verb
 * \param uc_mgr Use case manager
 * \param device Device
 * \return Zero if success, otherwise a negative error code
 */
int snd_use_case_disable_device(snd_use_case_mgr_t *uc_mgr, const char *device);

/**
 * \brief Enable use case modifier for current use case verb
 * \param uc_mgr Use case manager
 * \param modifier Modifier
 * \return Zero if success, otherwise a negative error code
 */
int snd_use_case_enable_modifier(snd_use_case_mgr_t *uc_mgr,
		const char *modifier);
		
/**
 * \brief Disable use case modifier for curent use case verb
 * \param uc_mgr Use case manager
 * \param modifier Modifier
 * \return Zero if success, otherwise a negative error code
 */
int snd_use_case_disable_modifier(snd_use_case_mgr_t *uc_mgr,
		const char *modifier);

/**
 * \brief Get current use case verb for sound card
 * \param uc_mgr Use case manager
 * \return Verb if success, otherwise NULL
 */
const char *snd_use_case_get_verb(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Get device status for current use case verb
 * \param uc_mgr Use case manager
 * \param device_name The device we are interested in.
 * \return - 1 = enabled, 0 = disabled, negative = error
 */
int snd_use_case_get_device_status(snd_use_case_mgr_t *uc_mgr,
		const char *device_name);

/**
 * \brief Get modifier status for current use case verb
 * \param uc_mgr Use case manager
 * \param device_name The device we are interested in.
 * \return - 1 = enabled, 0 = disabled, negative = error
 */
int snd_use_case_get_modifier_status(snd_use_case_mgr_t *uc_mgr,
		const char *modifier_name);

/**
 * \brief Get the current use case verb QoS
 * \param uc_mgr Use case manager
 * \return QoS level
 */
enum snd_use_case_qos snd_use_case_get_verb_qos(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Get use case modifier QoS
 * \param uc_mgr use case manager
 * \param modifier Modifier
 * \return QoS level
 */
enum snd_use_case_qos snd_use_case_get_mod_qos(snd_use_case_mgr_t *uc_mgr,
	const char *modifier);

/**
 * \brief Get the current use case verb playback PCM sink ID.
 * \param uc_mgr use case manager
 * \return PCM number if success, otherwise negative
 */
int snd_use_case_get_verb_playback_pcm(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Get the current use case verb capture PCM source ID
 * \param uc_mgr Use case manager
 * \return PCM number if success, otherwise negative
 */
int snd_use_case_get_verb_capture_pcm(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Get use case modifier playback PCM sink ID
 * \param uc_mgr Use case manager
 * \param modifier Modifier
 * \return PCM number if success, otherwise negative
 */
int snd_use_case_get_mod_playback_pcm(snd_use_case_mgr_t *uc_mgr,
	const char *modifier);

/**
 * \brief Get use case modifier capture PCM source ID
 * \param uc_mgr Use case manager
 * \param modifier Modifier
 * \return PCM number if success, otherwise negative
 */
int snd_use_case_get_mod_capture_pcm(snd_use_case_mgr_t *uc_mgr,
	const char *modifier);

/**
 * \brief Get ALSA volume/mute control IDs depending on use case device.
 * \param uc_mgr Use case manager
 * \param type The control type we are looking for
 * \param device The device we are interested in.
 * \return ID if success, otherwise a negative error code
 *
 * Get the control id for common volume and mute controls that are aliased
 * in the current use case verb.
 */
int snd_use_case_get_device_ctl_elem_id(snd_use_case_mgr_t *uc_mgr,
		enum snd_use_case_control_alias type, const char *device);

/**
 * \brief Get ALSA volume/mute control IDs depending on use case modifier.
 * \param uc_mgr Use case manager
 * \param type The control type we are looking for
 * \param modifier The modifier we are interested in.
 * \return ID if success, otherwise a negative error code
 *
 * Get the control id for common volume and mute controls that are aliased
 * in the current use case modifier.
 */
int snd_use_case_get_modifier_ctl_elem_id(snd_use_case_mgr_t *uc_mgr,
		enum snd_use_case_control_alias type, const char *modifier);

/**
 * \brief Clients can register to be notified when use case changes.
 * \param notifier Client notify callback.
 * \param data Client private data.
 * \return 0 on success, otherwise errno
 */
int snd_use_case_register_notifier(snd_use_case_mgr_t *uc_mgr,
		snd_use_case_notifier_t notifier, void *data);

/**
 * \brief Unregister client notifier.
 * \param notifier Client notify callback.
 * \return 0 on success, otherwise errno
 */
int snd_use_case_unregister_notifier(snd_use_case_mgr_t *uc_mgr,
		snd_use_case_notifier_t notifier);

/**
 * \brief Open and initialise use case core for sound card
 * \param card_name Sound card name.
 * \param shared Will more than 1 client control/monitor use cases.
 * \return Use case handle if success, otherwise NULL
 */
snd_use_case_mgr_t *snd_use_case_mgr_open(const char *card_name, int shared);


/**
 * \brief Reload and re-parse use case configuration files for sound card.
 * \param uc_mgr Use case manager
 * \return zero if success, otherwise a negative error code
 */
int snd_use_case_mgr_reload(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Close use case manager
 * \param uc_mgr Use case manager
 * \return zero if success, otherwise a negative error code
 */
int snd_use_case_mgr_close(snd_use_case_mgr_t *uc_mgr);

/**
 * \brief Dump current sound card use case control settings
 * \param uc_mgr Use case manager
 * \param output Output handle
 * \return zero if success, otherwise a negative error code
 */
int snd_use_case_dump(snd_use_case_mgr_t *uc_mgr, snd_output_t *output);

/**
 *  \}
 */

#ifdef __cplusplus
}
#endif

#endif /* __ALSA_USE_CASE_H */
